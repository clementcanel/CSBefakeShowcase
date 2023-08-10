## beFake


beFake is a social media application inspired by BeReal. It fosters a unique competitive environment where users engage in friendly rivalry with classmates and co-workers to determine whose uploaded photos and posts exude the most authenticity.

![image](https://github.com/lmu-cmsi2022-spring2023/befake-redux/assets/112435653/9f252793-9d55-45e9-b5df-7f247d6d5e71)  

## Features

### Technology Highlights
- **Firebase Integration:** Seamlessly integrate Firebase backend services to power the app's functionality.
- **Viber REST API:** Leveraging the Viber REST API to enhance user experience.

### Core Features
- **User Login & Signup:** Utilize Firebase Authentication for a secure and streamlined user authentication and registration process.
- **Post Photos with Like/Dislike:** Leverage Firebase Firestore to allow users to share photos and interact with content through likes and dislikes.
- **Reset Password/Email:** Provide users with the convenience of password reset via Firebase Authentication's email services.
- **Photos from Camera Roll:** Access and upload photos directly from the device's camera roll using Firebase Storage.
- **Navigation between Posts & Profiles:** Implement smooth navigation between posts and user profiles with Firebase's real-time database capabilities.

### Additional Features
- **Text Accompaniment for Photos:** Enhance storytelling by providing textual context alongside photos, utilizing Firebase Firestore for content storage.

![image](https://github.com/lmu-cmsi2022-spring2023/befake-redux/assets/112435653/a83cbe7e-e72e-489e-8380-bbbe5caff9e1)
![image](https://github.com/lmu-cmsi2022-spring2023/befake-redux/assets/112435653/85c9a7d2-1a87-4dc3-b9c4-d4a52efa538c)

## Todo

- [ ] **Resolve Lingering Sync Glitch:** Investigate and fix the issue where likes occasionally revert to their previous value during app interaction with the backend.

- [ ] **Abstract Firestore Invocations:**
  - [ ] ProfileView
  - [ ] CreateNewPost
  - [ ] LoginView
  - [ ] RegisterView
  Create abstractions for these components to improve code structure and maintainability.

- [ ] **Address Warning Messages:**
  - [ ] Warning 1
  - [ ] Warning 2
  - [ ] Warning 3
  Update the code to eliminate these warnings during the build process.

- [ ] **Implement Post Limit Per Day:**
  Allow users to create only one post per day to encourage more thoughtful and genuine content sharing.
  Enforce a one-post-per-day rule by creating a backend API that tracks users' daily posts and prevents exceeding the limit.

- [ ] **Introduce Local and Global Leaderboards:**
  - [ ] Local Leaderboard:
      Display a leaderboard within specific user communities (classmates or co-workers) to showcase the users with the most authentic posts.
  - [ ] Global Leaderboard:
      Establish a global leaderboard that highlights the most authentic posts across all users on the platform.
  Integrate scoring logic into posts based on engagement and authenticity, store scores in the backend database, and design separate local and global leaderboards to showcase top-scoring users.


