
#### install and start jupyter
~~~shell
    pip install jupyter notebook

    jupyter notebook
~~~

https://github.com/KIPAC/StatisticalMethods/

#### 概率基础

采样器  
    Sampler: 产生满足目标分布的一个随机变量的函数或方法  

先验分布

联合后验分布

    似然函数

    采样

多元正态分布

$$ x \sim N(\mu, \Sigma) $$

#### 背景
造父变星(Cepheids)是亮度周期性稳定变化的恒星，其对数与它们的平均绝对星等紧密相关。

我们将使用Riess等人的数据。 （2011; R11）来分层推断附近星系样本中控制造父变星周期-光度关系的超参数，并回答以下问题：

考虑了星系距离的因素后,造父变星的周期-光度的关系有多普遍?

目视星等 Apparent magnitude  
目视星等跟绝对星等满足关系:

$m = M + 5log_{10}D_L + 25$

Model

In cepheids, absolute magnitude is related to the log period  log10𝑃  via a simple, linear relation
𝑀=𝑎𝑖+𝑏𝑖log10𝑃  with  𝑖  indexing the host galaxies.
在造父变星中,绝对星等跟周期对数 $log_10 P$通过一个简单的线性关系 𝑀=𝑎𝑖+𝑏𝑖log10 P联系,这里i表示host星系的下标。

宿主星系中的周期-光度关系可能互不相同，但差异不大。

我们假设斜率和截距参数来自两个独立的高斯分布, 分别是未知宽度（𝜎𝑏和𝜎𝑎）和均值（𝑏¯和𝑎¯）的，使得造父变星的行为大致相同，但仍可能对宿主星系环境敏感。

Let's also assume that there is no intrinsic scatter in the cepheid period-luminosity relation within a given host galaxy.

the measurement errors given by merr are Gaussian.
periods are known precisely.

intercept parameter 截距

luminosity distance 光度距离

weighted least squares (WLS)

statsmodels.api.WLS

#### 天文学相关教程
大众天文学  

天体物理概论  

比如本书没讲到辐射的基本物理概念，康普顿闪射，切伦科夫效应以及其他辐射理论，这些理论的讲述可以参看李宗伟老师的《天体物理学》一书

taotie里的Astronomy or Astrophysics Related Topics一节
推荐指数: ***




