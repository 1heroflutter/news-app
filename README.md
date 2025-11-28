#News_reader_app

News Content Aggregator & Reading
A full-stack mobile application designed for efficient content aggregation, personalized reading, and real-time news delivery. The backend is built with Node.js and uses MongoDB for flexible, scalable data storage, handling all content APIs and user authentication securely.

#Screenshots

| ![Login](news/assets/images/screenshots/login.jpg) | ![Country](news/assets/images/screenshots/country.jpg) | ![topic](news/assets/images/screenshots/topic_select.jpg) | ![Home](news/assets/images/screenshots/home_light.jpg) | ![Dark](news/assets/images/screenshots/home_dark.jpg) | ![Explore](news/assets/images/screenshots/explore.jpg) | ![Setting](news/assets/images/screenshots/setting.jpg) | ![latest](news/assets/images/screenshots/latest.jpg) | ![News](news/assets/images/screenshots/news_reader.jpg) | ![Search](news/assets/images/screenshots/search_news.jpg) |
|:-------------------------------------------:|:------------------------------------------------:|:---------------------------------------------:|:-----------------------------------------------------:|:-------------------------------------------------:|:---------------------------------------------------------------:|:-------------------------------------------:|:---------------------------------------------------:|:-------------------------------------------------------:|:---------------------------------------------------------:|:----------------------------------------------------------:|


✨ Key Features

The application provides a seamless reading experience supported by a robust backend infrastructure. Key features include:

Secure Authentication: User sign-up and sign-in managed via JWT (JSON Web Tokens) for secure API access.

Real-Time Content API: RESTful API endpoints for fetching categorized news, trending topics, and full article content.

Personalized Feeds: Ability to filter news based on user-selected categories and reading history.

Bookmarking/Saving: Functionality for authenticated users to save articles for later reading.

Scalable Architecture: Modular, decoupled architecture separating the mobile client from the API service layer.

🛠️ Tech Stack & Architecture

| Mobile Framework | Flutter / React Native (Placeholder) |
| State Management | (Depend on Mobile Framework) |
| Backend / API | Node.js (Express.js) |
| Database | MongoDB (using Mongoose or native driver) |
| Authentication | JSON Web Tokens (JWT) |
| External Data | Third-party News Aggregation API (e.g., NewsAPI, GNews) |

🚀 Getting Started

Follow these steps to set up and run the project locally.

1. Backend Setup (Node.js/MongoDB)

Clone Repository:

git clone [YOUR_REPOSITORY_URL]
cd news_reader_app/backend


Install Dependencies:

npm install


Configure Environment:

Create a .env file in the backend/ directory.

Add your MongoDB connection string, JWT secret, and API key placeholders:

# MongoDB Connection
MONGO_URI="mongodb://localhost:27017/news-db"

# Security
JWT_SECRET="YOUR_STRONG_SECRET_KEY"

# External News API Key
NEWS_API_KEY="YOUR_EXTERNAL_API_KEY"

# Server Port
PORT=3000


Start the Backend Server:

npm start # or npm run dev


The API should now be running on http://localhost:3000.

2. Frontend Setup (Mobile Application)

Navigate to Mobile Project:

cd ../frontend # Adjust this path based on your actual structure


Install Dependencies:

# For Flutter: flutter pub get
# For React Native: npm install


Update API URL:

In your frontend code (e.g., a configuration file or constants), update the base API URL to point to your local Node.js server (e.g., http://10.0.2.2:3000 for Android emulator, or http://localhost:3000 for web/desktop).

Build & Run:

# For Flutter: flutter run
# For React Native: npm run android / npm run ios
