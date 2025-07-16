# 🎬 Miniflix - Mini Movie App Project

Miniflix เป็นมินิโปรเจกต์สำหรับทดลองพัฒนาแอปแสดงข้อมูลภาพยนตร์ โดยเน้นการใช้โครงสร้าง **Clean Architecture**, การจัดการสถานะด้วย **Provider**, และการเรียกใช้งาน API ผ่าน **Retrofit (Dio)**

## 🧠 จุดประสงค์ของโปรเจกต์

โปรเจกต์นี้จัดทำขึ้นเพื่อทดลองและฝึกฝนความเข้าใจในเรื่อง:

- State Management ด้วย Provider
- โครงสร้าง Clean Architecture
- การเรียก REST API ด้วย Retrofit (Dio)
- การจัดระเบียบโค้ดให้ดูแลรักษาง่าย

## 📁 โครงสร้างโปรเจกต์

```
lib/
├── model/
│   ├── apis/         # ไฟล์ที่เกี่ยวข้องกับ API เช่น model, retrofit, dio client
│   ├── service/      # จัดการ service logic
├── router/           # เส้นทางของแอป (GoRouter)
├── util/             # ไฟล์ช่วยเหลือ เช่น คอนฟิก, ฟังก์ชันทั่วไป
├── view/
│   ├── component/    # UI Components แยกออกจากกัน
│   ├── otherpage/    # หน้าอื่นๆ เช่น Detail
├── viewmodel/        # Provider และ logic ที่ผูกกับ view
└── main.dart         # จุดเริ่มต้นของแอป
```

## 🚧 สถานะการพัฒนา

โปรเจกต์ยังอยู่ระหว่างการพัฒนา ผู้ใช้งานสามารถทดลองหรือช่วยพัฒนาได้ตามสะดวก

## 🗝️ การตั้งค่า API Key

แอปนี้ใช้ข้อมูลจาก [The Movie Database (TMDB)](https://www.themoviedb.org/)

หากต้องการทดลองใช้งาน ให้ทำตามขั้นตอนต่อไปนี้:

1. ลงทะเบียนที่ [TMDB](https://www.themoviedb.org/)
2. ไปที่เมนู **Settings** > **API**
3. ขอรับ **API Key**
4. นำ API Key ที่ได้ไปใส่ไว้ในไฟล์ api_key.dart ในตัวแปร:
   const String apiKey = "YOUR_API_KEY_HERE";