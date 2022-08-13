
本人二十多年前开始对图形学有兴趣，并进行自学。那时候能找到的学习材料比较杂乱，有来自BBS的文档及代码，有一些不太系统的书籍。后来开始阅读著名的教材《Computer Graphics (豆瓣): Principle and Practice 2nd Edition》（CGPP），发觉非常难读，当然一方面是自己的能力有限（那时候高一），另一方面是觉得有些比较简单的部分花了很多篇幅，有些重点的学习曲线非常陡峭。


第二版的资料比较过时，但过了二十多年作者们才出了第三版，我买了一本（右图），但只读了一小部分，所以不在此妄下评论。

对于学习计算机图形，我觉得需要考虑是以哪种心态去学习。如果只是想了解一下，体验一下，可以选择一些较简单的方式，例如Processing相关的。《The Nature of Code (豆瓣)》是一本写给任何程序员甚至是非程序员，有关图形、动画的书，使用Processing作为例子。网上版是免费的The Nature of Code，国内也快有翻译版《代码本色：用编程模拟自然系统 (豆瓣)》，本人第一次获邀写本书的推荐序（求轻拍……）。



如果希望更正统地去学习，可以选择公开课及大学教科书。我并没有这方面的学习经验，但似乎《Fundamentals of Computer Graphics, Third Edition (豆瓣)》是一个不错的选择，作者是Utah及Cornell的教授，而且本书曾用于多所大学的课程（见Fundamentals of Computer Graphics, Third Edition）。



另一本常作为教材，但只集中讨论离线渲染的是《Physically Based Rendering, Second Edition (豆瓣)》（PBRT）。它的一个优越之处是配合开源项目mmp/pbrt-v2 · GitHub，而且书里采用了文学编程（Literate programming）方式去展示源代码，这样会更容易理解代码和理论之间的关联。



提到PBRT，不能不提《Real-Time Rendering, Third Edition (豆瓣)》（RTR）。相对于制作CG（动画电影、电影特效）的离线渲染，实时渲染是游戏的核心部分，这本书被誉为游戏引擎开发者的天书。这本书的内容非常多，涉及实时渲染的方方面面，写作手法亦非常简明易读。但由于许多细节内容实在放不进这本超过1000页的著作，但作者们非常仔细地包含了大量的参考文献，可以作为这个领域的指南。但第3版已经是2008年出版，期待第4版。



对于想做实时渲染的朋友，必须要学习相关的API。现时基本上是Direct3D 9/11、OpenGL 3.x/4.x、OpenGL ES 2/3、WebGL，还有一些新的API如iOS的Metal、AMD的Mantle。

Direct3D 比较多人阅读的是龙书《Introduction to 3D Game Programming with DirectX 11 (豆瓣)》，但DirectX11版已没有龙做封面了。



不过如果对Direct3D9或OpenGL API已有经验，可以阅读《Practical Rendering and Computation with Direct3D 11 (豆瓣)》。这本书基本可以代替MSDN的相关介绍，并有几章比较实际应用上的问题处理。



而OpenGL的经典则是红书《OpenGL Programming Guide (豆瓣)》，现时已经是第8版。我已忘记最初是看哪一版，不过当时的确觉得非常易读。



OpenGL还有一本比较流行的书籍《OpenGL Superbible (豆瓣)》。



计算机图形学可能是在计算机出版中，首先以Gems形式把一些投稿结集出版的学科。1990年开创《Graphics Gems (豆瓣)》系列，2002年开始了《Direct3D ShaderX (豆瓣)》系列，2004年的《GPU Gems (豆瓣)》系列1，2010年的《GPU Pro (豆瓣)》系列等。这些书籍主要是业界（部分学界）发表最新技巧、技术的地方。完整列表可参考計算機圖形: Gems類。



上面的都是比较广泛地讨论计算机图形及API的书籍，但计算机图形的每一个范畴，例如实时图形的阴影、流体模拟及渲染、曲面建模、地形渲染、皮肤渲染……许多许多题目都足以写一本甚至几本专著。可以参考 計算機圖形: 進階/專門。




介绍到这里，以为完了吧？不，还有一类书籍，把计算机图形相关的文章结集出版。例如《Jim Blinn's Corner (豆瓣)》。Jim Blinn何许人也？就是发明Blinn-Phong Reflection Model、environment mapping、bump mapping的大牛。类似的书籍可参考 計算機圖形: 專欄結集。




还有，计算机图形离不开数学，相关书籍可参考此答案：
与游戏或图形编程相关，有哪些好的数学和物理的书？ - Milo Yip 的回答

我搜集了不少计算机图形书籍，做成豆列（但只有少量评语） ：
計算機圖形: 入門/API類 http://book.douban.com/doulist/1445744/
計算機圖形: 進階/專門 http://book.douban.com/doulist/1445680/
計算機圖形: Gems類 http://book.douban.com/doulist/1445745/
計算機圖形: 專欄結集 http://book.douban.com/doulist/1445806/
計算機圖形: 動畫 http://book.douban.com/doulist/1445716/
計算機圖形: 相關數學 http://book.douban.com/doulist/1445735/
計算機圖形: 其他參考 http://book.douban.com/doulist/1447740/