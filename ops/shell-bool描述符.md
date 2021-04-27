举例:

if [ -e $SOCKNAME -a ! -f mr-done ]; then
    echo done
fi

-e FILENAME: 文件是否存在
-a 与条件
-f FILENAME: 文件是否存在且为regular file
! -f 文件是否不存在
