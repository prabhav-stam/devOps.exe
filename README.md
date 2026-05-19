# CleanIndia – Civic Issue Reporting Platform

CleanIndia is a full-stack web application that enables citizens to report civic issues such as potholes, garbage accumulation, drainage overflow, and other infrastructure problems. Users can submit complaints with location details and images, while the platform visualizes issues on an interactive map to help authorities monitor and resolve them efficiently.

---

## 🌐 Live Demo

Try the application here:

**Live Website:**
https://cleanindia-two.vercel.app/

---

## 🚀 Features

* 📍 Location-based issue reporting
* 🗺 Interactive map visualization using OpenStreetMap
* 🧾 Complaint lifecycle tracking (Pending → In Progress → Resolved)
* 📷 Image-based complaint submission
* ⚡ Responsive modern UI
* ☁ Cloud database storage with MongoDB Atlas

---

## 🛠 Tech Stack

### Frontend

* React (Vite + TypeScript)
* Tailwind CSS
* Leaflet
* OpenStreetMap

### Backend

* Node.js
* Express.js
* REST APIs

### Database

* MongoDB Atlas

### Deployment

* Frontend → Vercel
* Backend → Render

---

## 📂 Project Structure

```
cleanindia
│
├── backend
│   ├── src
│   ├── dist
│   ├── package.json
│   └── tsconfig.json
│
├── frontend
│   ├── public
│   ├── src
│   │   ├── assets
│   │   ├── components
│   │   ├── pages
│   │   ├── App.tsx
│   │   └── main.tsx
│   ├── tailwind.config.js
│   ├── vite.config.ts
│   └── package.json
│
└── README.md
```

---

## ⚙️ Local Setup

### Clone repository

```bash
git clone https://github.com/Vinay-Budde/cleanindia.git
cd cleanindia
```

### Run Backend

```bash
cd backend
npm install
npm run dev
```

### Run Frontend

```bash
cd frontend
npm install
npm run dev
```

Frontend runs on:

```
http://localhost:5173
```

---

## 🔑 Environment Variables

Backend `.env`

```
MONGO_URI=your_mongodb_connection_string
PORT=5000
JWT_SECRET=your_secret
```

Frontend `.env`

```
VITE_API_URL=https://your-backend-url
```

---

## 📌 Future Improvements

* AI-based issue severity detection
* Duplicate complaint detection
* Heatmap visualization of complaints
* Admin analytics dashboard
* Mobile application version

---

## 👨‍💻 Author

**Vinay Budde**

GitHub:
https://github.com/prabhav-stam

---

## 📜 License

This project is built for educational and demonstration purposes.
﻿# cleanindia

