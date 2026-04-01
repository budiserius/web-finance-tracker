```
my_fastapi_app/
├── app/
│   ├── __init__.py
│   ├── main.py              # Entry point aplikasi
│   ├── api/                 # Folder untuk semua route/endpoint
│   │   ├── __init__.py
│   │   └── v1/              # Versi API (Best practice)
│   │       ├── __init__.py
│   │       └── api.py       # Router utama v1
│   ├── core/                # Konfigurasi global (Security, Settings)
│   │   ├── __init__.py
│   │   └── config.py
│   ├── models/              # Database models (SQLAlchemy/Tortoise)
│   ├── schemas/             # Pydantic models (Data validation)
│   ├── services/            # Logika bisnis utama
│   └── db/                  # Koneksi database dan sesi
├── tests/                   # File pengujian (Pytest)
├── .env                     # Variabel rahasia (DB_URL, API_KEY)
├── .gitignore
├── requirements.txt
└── README.md
```

- Schemas vs Models: Gunakan folder `models/` untuk struktur tabel database dan `schemas/` untuk validasi input/output (Pydantic). Ini menjaga keamanan data kamu.

- Versioning: Selalu gunakan prefix `/api/v1` agar jika ada perubahan besar di masa depan, kamu tidak merusak integrasi pengguna yang lama.

- Dependencies: Jika butuh koneksi DB, buatlah fungsi dependency injection di folder `app/db/`.
