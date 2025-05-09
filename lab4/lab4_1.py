import cv2

# Завантаження класифікатора Haarcascade
face_cascade_db = cv2.CascadeClassifier(cv2.data.haarcascades + "haarcascade_frontalface_default.xml")

# Завантаження зображення
img = cv2.imread("photo2.jpg")

# Перетворення зображення у відтінки сірого
img_gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

# Розпізнавання обличчя
faces = face_cascade_db.detectMultiScale(img_gray, scaleFactor=1.1, minNeighbors=5)

# Відображення рамок на зображенні
for (x, y, w, h) in faces:
    cv2.rectangle(img, (x, y), (x+w, y+h), (0, 255, 0), 2)

# Виведення результату
cv2.imshow('Detected Faces', img)
cv2.waitKey(0)
cv2.destroyAllWindows()
