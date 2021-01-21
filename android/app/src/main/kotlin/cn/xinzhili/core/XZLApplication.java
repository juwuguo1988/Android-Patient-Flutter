package cn.xinzhili.core;

import android.content.Context;

import androidx.multidex.MultiDex;
import io.flutter.app.FlutterApplication;

public class XZLApplication extends FlutterApplication {
    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }

    @Override
    public void onCreate() {
        super.onCreate();
    }
}