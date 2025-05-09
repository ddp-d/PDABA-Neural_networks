import cv2

face_cascade_db = cv2.CascadeClassifier(cv2.data.haarcascades + "haarcascade_frontalface_default.xml")

# Завантаження відео-файлу
cap = cv2.VideoCapture("video2.mp4")

while cap.isOpened():
    success, frame = cap.read()
    if not success:
        break

    img_gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    faces = face_cascade_db.detectMultiScale(img_gray, scaleFactor=1.1, minNeighbors=5)

    for (x, y, w, h) in faces:
        cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)

    cv2.imshow('Face Detection from Video', frame)

    if cv2.waitKey(25) & 0xff == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
