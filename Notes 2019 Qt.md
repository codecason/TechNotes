
1. Step 1
安装qtcreator, qmake, mingw

	Qt新建项目No valid kits found解决思路


2. Step 2
	Visual Studio集成qtstudio
	Qt版本->手动设置，添加qmake路径C:\Qt\4.8.6_MinGW\bin\qmake.exe。

	qt-win-opensource-4.8.5-mingw.exe

	添加MinGW，并设置相应路径。
	编译器路径C:\Qt\mingw32\bin\g++.exe。

	wget https://www.qt.io/download

	http://download.qt.io/official_releases/ # previous versions

3.
	桌面软件，涉及到数据库、网络的，没有比用Delphi、CB更方便的。VB6也可以，只是VB6太老了，不支持64位开发，网络协议支持也比较弱。
	界面：MFC、QT、WTL
	服务器：java、vb.net、python、delphi、c++builder等等

4.
E.X. 创建新线程 core.cpp
~~~c
    QThread* thread = new QThread();
    if (thread == nullptr) {
        qCritical() << "could not allocate Core thread";
        return {};
    }
    thread->setObjectName("qTox Core");

    auto toxOptions = ToxOptions::makeToxOptions(savedata, settings);
    if (toxOptions == nullptr) {
        qCritical() << "could not allocate Tox Options data structure";
        if (err) {
            *err = ToxCoreErrors::ERROR_ALLOC;
        }
        return {};
    }

    ToxCorePtr core(new Core(thread));
    if (core == nullptr) {
        if (err) {
            *err = ToxCoreErrors::ERROR_ALLOC;
        }
        return {};
    }
~~~

Notes:
    unique_ptr<QObject> obj = nullptr;

6.
emit 信号
core.cpp
~~~c
        tox_callback_friend_request(tox, onFriendRequest);
        signal:
        void Core::onFriendRequest(Tox*, const uint8_t* cFriendPk, const uint8_t* cMessage,
                                size_t cMessageSize, void* core)
        {
            ToxPk friendPk(cFriendPk);
            QString requestMessage = ToxString(cMessage, cMessageSize).getQString();
            emit static_cast<Core*>(core)->friendRequestReceived(friendPk, requestMessage);
        }

        connect:
        void Nexus::showMainGUI() {
            connect(core, &Core::friendRequestReceived, widget, &Widget::onFriendRequestReceived);
        }

        slot:
        void Widget::onFriendRequestReceived(const ToxPk& friendPk, const QString& message)
        {
            if (addFriendForm->addFriendRequest(friendPk.toString(), message)) {
                friendRequestsUpdate();
                newMessageAlert(window(), isActiveWindow(), true, true);
        #if DESKTOP_NOTIFICATIONS
                if (settings.getNotifyHide()) {
                    notifier.notifyMessageSimple(DesktopNotify::MessageType::FRIEND_REQUEST);
                } else {
                    notifier.notifyMessage(friendPk.toString() + tr(" sent you a friend request."), message);
                }
        #endif
            }
        }
~~~

7.

    libevent for qt的讨论
    http://qtcn.org/bbs/simple/?t60285.html

    理论上说是boost效率更高的。但是boost的学习曲线不好弄得。
    我现在也没系统学习过boost，我封装asio是利用C++11 版的asio，可以不依赖boost的（定时器和序列化除外）。

    定时器构建于Qt事件循环机制,多线程下没有实时调用

8.
    qTox 代码的注册机制
        std::uniform_int_distribution 离散均匀分布
~~~c
    std::default_random_engine randEngine((std::random_device())());
    std::uniform_int_distribution<uint64_t> distribution;
    globalId = distribution(randEngine);
~~~

9.    复习:

epoll相关API:
~~~c
    ev.events = EPOLLIN | EPOLLET;
    epoll_ctl(epfd, EPOLL_CTL_MOD, connfd, &ev);
~~~