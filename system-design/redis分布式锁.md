场景分析:

2.6.12版本之前，由于没有一个上述的原子命令，需要一些命令组合实现，但不能简单的使用setNx、expire这两个命令，因为如果setNx成功，expire命令失败时，恰好执行删除lockKey的也执行失败，key就永远不会过期，就会出现死锁问题，

Redis在京东到家订单中的使用

#### setnx

setnx(key, val)  
    如果有该值, 则不加锁, 否则加锁成功  

set_expire(key, ttl)  
    场景2: 在setnx后, 可能setnx成功而expire失败,而且捕捉异常也解锁失败,后续的客户端请求一直失败(造成死锁)

set(key, val, expire_time)  
    2.6.12加入了ttl, 这样可以防止场景2  

场景3: 加锁后执行时间无法确定, 可能执行时间>ttl,在过程中锁被释放,造成A删除了B(后获取)的锁;  
        解决方案: 需要一直renew,设为auto_renewable  

场景4: 事务场景, 加锁之后未获得锁的客户端还一直expire(这是代码的问题)

其他: 释放锁的时候, 判断 value 是自己 和删除 key 是两个独立的操作, 利用lua脚本来实现原子性
~~~lua
if redis.call("get",KEYS[1]) == ARGV[1] then
    return redis.call("del",KEYS[1])
else
    return 0
end
~~~
