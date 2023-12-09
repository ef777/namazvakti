

package com.namaz.vaktim.namazvakti
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import androidx.annotation.NonNull
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import android.app.PendingIntent
import android.content.Intent
import android.widget.RemoteViews
import kotlin.random.Random
import android.util.Log
import android.net.Uri
import android.media.MediaPlayer
import java.util.Locale
import android.app.AlarmManager
import android.content.BroadcastReceiver
import java.text.SimpleDateFormat
val CHANNEL = "localnot"
class MainActivity: FlutterActivity() {
         val CHANNEL = "localnot" // Kullanılacak kanal ID'sini buraya yazın
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->

           /*   if  (call.method == "showCustomNotification2") {
                val saat = call.argument<String>("saat")
                val title = call.argument<String>("title")
                val content = call.argument<String>("content")
                val ilce = call.argument<String>("ilce")
                val kalan_vakit = call.argument<String>("kalan_vakit")
                val time1 = call.argument<String>("time1")
                val time2 = call.argument<String>("time2")
                val time3 = call.argument<String>("time3")
                val time4 = call.argument<String>("time4")
                val time5 = call.argument<String>("time5")
                val time6 = call.argument<String>("time6")

                if (saat != null && title != null && content != null && ilce != null && kalan_vakit != null && time1 != null && time2 != null && time3 != null && time4 != null && time5 != null && time6 != null)  {
                    showCustomNotification2 ( context, saat,title,content, ilce, kalan_vakit,time1,time2,time3,time4,time5,time6 ) 
                    Log.d("MyTag", "ayarlandi");

                }*/
       
             if  (call.method == "setAlarm") {
                val saat = call.argument<String>("saat")
                val title = call.argument<String>("title")
                val content = call.argument<String>("content")
                val ilce = call.argument<String>("ilce")
                val kalan_vakit = call.argument<String>("kalan_vakit")
                val time1 = call.argument<String>("time1")
                val time2 = call.argument<String>("time2")
                val time3 = call.argument<String>("time3")
                val time4 = call.argument<String>("time4")
                val time5 = call.argument<String>("time5")
                val time6 = call.argument<String>("time6")

                if (saat != null && title != null && content != null && ilce != null && kalan_vakit != null && time1 != null && time2 != null && time3 != null && time4 != null && time5 != null && time6 != null)  {
                    setAlarm(context, saat,title,content, ilce, kalan_vakit,time1,time2,time3,time4,time5,time6 )
                    Log.d("MyTag", "ayarlandi");

                }
                result.success("Alarm ayarlandı")
            }
            
            else {
                result.notImplemented()
            }
        }
    }
}
   // return 
  
   fun setAlarm(context: Context, time: String, title: String, content: String , ilce: String, kalan_vakit: String, time1: String,time2: String,time3: String,time4: String,time5: String,time6: String  ) {
    
    val df = SimpleDateFormat("dd.MM.yyyy:HH:mm", Locale.getDefault())  
    Log.d("MyTag", "iste df   $df");

    val date = df.parse(time)
    Log.d("MyTag", "iste date   $date");

    val targetTime = date.time
    Log.d("MyTag", "iste targetTime   $targetTime");
    val random = Random
    val ID = random.nextInt() //örnek
    Log.d("MyTag", "alarm ayarlanıyor");
    Log.d("MyTag", "$time");
    Log.d("MyTag", "$title");
    Log.d("MyTag", "$content");

    val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
    
    val channelId = "localnot"

   /*  if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
        val name = "Custom Notification Channel"
        val descriptionText = "Custom notifications"
        val importance = NotificationManager.IMPORTANCE_HIGH
        val channel = NotificationChannel(channelId, name, importance).apply {
            description = descriptionText
        }
       // val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        val notificationManager: NotificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            
        notificationManager.createNotificationChannel(channel)
    } */
    // Intent
    val intent = Intent(context, AlarmReceiver::class.java)

    intent.putExtra("ilce", ilce)
    intent.putExtra("kalan_vakit", kalan_vakit)
    intent.putExtra("time1", time1)
    intent.putExtra("time2", time2)
    intent.putExtra("time3", time3)
    intent.putExtra("time4", time4)
    intent.putExtra("time5", time5)
    intent.putExtra("time6", time6)
    intent.putExtra("notificationId", ID)
    intent.putExtra("title", title)
    intent.putExtra("content", content) 
    intent.putExtra("time", df.format(date))
    Log.d("MyTag", "intent kuruldu");
    val flag: Int = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
        PendingIntent.FLAG_IMMUTABLE
    } else {
        0
    }
    val pendingIntent = PendingIntent.getBroadcast(context, ID, intent,  flag    )  
  
    Log.d("MyTag", "alarm sözde kuruldu!");

    // Alarmı ayarla
    alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, targetTime, pendingIntent)
    if (isAlarmSet(context, ID)) {
        Log.d("MyTag", "Alarm onaylandı")
    } else {
        Log.d("MyTag", "Alarm kurulamadı!")

    }
    Log.d("MyTag", "alarm son");

  }
  

  fun isAlarmSet(context: Context, alarmId: Int, ): Boolean {
    val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
    val intent = Intent(context, AlarmReceiver::class.java)
    val flag: Int = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
        PendingIntent.FLAG_IMMUTABLE
    } else {
        0
    }
    val pendingIntent = PendingIntent.getBroadcast(context, alarmId, intent, flag)
    
    // Eğer PendingIntent null değilse, alarm kurulmuş demektir
    if (pendingIntent != null) {
        Log.d("MyTag", "pendingIntent  kurulu")


        // Alınan zaman bilgisini beklenen zamanla karşılaştır
  
            return true
        
    }
    
    return false
}

 
    // Broadcast Receiver
    class AlarmReceiver : BroadcastReceiver() {
  
      override fun onReceive(context: Context, intent: Intent) {
        Log.d("MyTag", "sbildirim gösterildi");
     
val title = intent.getStringExtra("title") 
val content = intent.getStringExtra("content")
val ilce = intent.getStringExtra("ilce")
val kalan_vakit = intent.getStringExtra("kalan_vakit")
val time = intent.getStringExtra("time")
val time1 = intent.getStringExtra("time1")
val time2 = intent.getStringExtra("time2")
val time3 = intent.getStringExtra("time3")
val time4 = intent.getStringExtra("time4")
val time5 = intent.getStringExtra("time5")
val time6 = intent.getStringExtra("time6")
val id = intent.getIntExtra("notificationId", 0)


if (title != null && content != null && time != null && id != null && ilce != null && kalan_vakit != null && time1 != null && time2 != null && time3 != null && time4 != null && time5 != null && time6 != null)  {
    Log.d("MyTag", "içerik boş değil")

Log.d("MyTag", title)
Log.d("MyTag", content)
Log.d("MyTag", time)
Log.d("MyTag", id.toString())
Log.d("MyTag", ilce)
Log.d("MyTag", kalan_vakit)
Log.d("MyTag", time1)
Log.d("MyTag", time2)
Log.d("MyTag", time3)
Log.d("MyTag", time4)
Log.d("MyTag", time5)
Log.d("MyTag", time6)

showCustomNotification2(context, title, content,ilce ,kalan_vakit, time1,time2,time3,time4,time5,time6 ,id) 
}
else {
    Log.d("MyTag", "içerik boş")
}
        // Bildirim gösterme kodu buraya
        
      }
  
    }
  
    
  /*    fun createNotificationChannel(context: Context) {
        // Bildirim kanalını oluşturun
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name = "Your Channel Name" // Kanal adını buraya yazın
            val descriptionText = "Your Channel Description" // Kanal açıklamasını buraya yazın
            val importance = NotificationManager.IMPORTANCE_HIGH
            val channel = NotificationChannel(CHANNEL, name, importance).apply {
                description = descriptionText
            }

            // Bildirim kanalını sistemde kaydedin
            val notificationManager: NotificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    } */

    fun showCustomNotification2(context: Context, title: String, content: String, ilce:String ,kalan_vakit : String,  time1: String,time2: String,time3: String,time4: String,time5: String,time6: String, notificationId: Int) {
        val channelId = "localnot"
    
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name = "Custom Notification Channel"
            val descriptionText = "Custom notifications"
            val importance = NotificationManager.IMPORTANCE_HIGH
            val channel = NotificationChannel(channelId, name, importance).apply {
                description = descriptionText
            }
          //  val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            val notificationManager: NotificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

             notificationManager.createNotificationChannel(channel)
        }
    
        val notificationLayout = RemoteViews(context.packageName, R.layout.notification_layout)
        notificationLayout.setTextViewText(R.id.notification_title, title)
        notificationLayout.setTextViewText(R.id.notification_kalan_vakit, kalan_vakit)
        notificationLayout.setTextViewText(R.id.notification_ilce, ilce)
        notificationLayout.setTextViewText(R.id.vakit_saat_1, time1)
        notificationLayout.setTextViewText(R.id.vakit_saat_2, time2)
        notificationLayout.setTextViewText(R.id.vakit_saat_3, time3)
        notificationLayout.setTextViewText(R.id.vakit_saat_4, time4)
        notificationLayout.setTextViewText(R.id.vakit_saat_5, time5)
        notificationLayout.setTextViewText(R.id.vakit_saat_6, time6)
        val soundUri = Uri.parse("android.resource://" + context.packageName + "/" + R.raw.ses)
        val soundUri2 = Uri.parse("android.resource://" + context.packageName + "/raw/ses")

        val builder = NotificationCompat.Builder(context, channelId)
        builder.setSound(soundUri2)
        val mediaPlayer = MediaPlayer.create(context, soundUri)

        mediaPlayer.start() // Ses dosyasını çalmak için
        
        // MediaPlayer ile işiniz bittiğinde kaynakları serbest bırakın
        mediaPlayer.setOnCompletionListener { mediaPlayer.release() }
        builder.setSmallIcon(R.drawable.app_icon)
        builder.setCustomContentView(notificationLayout) // Önemli: Bu genişletilmiş bildirim oluşturur
        builder.setPriority(NotificationCompat.PRIORITY_HIGH)
       builder.setCustomBigContentView(notificationLayout)
     //   builder.setCustomHeadsUpContentView(notificationLayout)
        builder.setVibrate(longArrayOf(1000, 1000, 1000, 1000, 1000))
        builder.setAutoCancel(true) // Bildirim tıklandığında otomatik olarak kapat

        builder.setContentTitle(title)
        builder.setContentText(content)
        builder.setSmallIcon(R.drawable.app_icon)
        builder.setVibrate(longArrayOf(1000, 1000, 1000, 1000, 1000))
     
        val notificationIntent = Intent(context, MainActivity::class.java)
        val flag: Int = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            PendingIntent.FLAG_IMMUTABLE
        } else {
            0
        }
        val contentIntent = PendingIntent.getActivity(context, 0, notificationIntent, flag)
        builder.setContentIntent(contentIntent)
    
        val notification = builder.build()
        NotificationManagerCompat.from(context).notify(notificationId, notification)
    }
    
   


