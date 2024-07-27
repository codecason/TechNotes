// https://stackoverflow.com/questions/17748078/simplest-and-understandable-example-of-volatile-keyword-in-java
// 构造一个没有volatile则无法停止的样例
class ConcurrencyDemo2 extends Thread {
    //volatile
    boolean keepRunning = true;

    public void run() {
        long count=0;
        while (keepRunning) {
            // System.out.println("Thread terminated."); //这里print了则内存也可能被刷新,运行仍然是正常的
            count++;
        }

        System.out.println("Thread terminated." + count);
    }

    public static void main(String[] args) throws InterruptedException {
        ConcurrencyDemo2 t = new ConcurrencyDemo2();
        t.start();
        Thread.sleep(1000);
        System.out.println("after sleeping in main");
        t.keepRunning = false;
        t.join();
        System.out.println("keepRunning set to " + t.keepRunning);
    }
}
