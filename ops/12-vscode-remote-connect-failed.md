出错信息: 
Resolver error: Error: at Function.Create


https://stackoverflow.com/questions/64034813/vs-code-remote-ssh-connection-not-working

#### 解决步骤(仅供参考)
1. 降低SSH-REMOTE的版本, V61.0  
    在vscode版本中选中install another version(先选择Enabled
    )  
2. 删掉~/.vs-codeserver  
3. Ctrl+Shift+P kill remote vscode  
4. 重启vs-code, 重新下载安装vscode  
