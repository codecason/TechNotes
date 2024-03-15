
#### 查看某个版本可用的CRD类型

kubectl api-resources --api-group=admissionregistration.k8s.io/v1 -owide

#### ConfigMap
configMap的volumeMount的name是谁的名字?
    referent的名字,即在deployment内部自己管理的一个变量名

~~~yml
# 引用者
volumeMounts:
- mountPath: /dev/shm
  name: shm
- mountPath: /mysql-init.sql
  name: mysql-init # self-defined

# 被引用者
volumes:
  - configMap:
      items:
      - key: cdb-abcdef--script28
        path: cdb-abcdef-0.sql
      name: db-init  # 在任意地方定义的名字,只要有就可以
    name: mysql-init # 被引用的名字
~~~
