import cv2

face_cascade_db = cv2.CascadeClassifier(cv2.data.haarcascades + "haarcascade_frontalface_default.xml")

# Захоплення потоку з веб-камери
cap = cv2.VideoCapture(0)

# Перевірка чи успішно відкрилась веб-камера
if not cap.isOpened():
    print("Помилка: не вдалося підключитися до камери.")
    exit()

while True:
    # Отримання кадру
    success, img = cap.read()

    # Перевірка отримання кадру
    if not success:
        print("Помилка: не вдалося отримати кадр із камери.")
        break

    # Конвертація у сірий відтінок
    img_gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    # Розпізнавання облич
    faces = face_cascade_db.detectMultiScale(img_gray, scaleFactor=1.1, minNeighbors=5)

    # Виведення рамок навколо облич
    for (x, y, w, h) in faces:
        cv2.rectangle(img, (x, y), (x + w, y + h), (0, 255, 0), 2)

    # Виведення результату
    cv2.imshow('Webcam Face Detection', img)

    # Вихід з циклу при натисканні 'q'
    if cv2.waitKey(1) & 0xff == ord('q'):
        break

# Звільнення ресурсів
cap.release()
cv2.destroyAllWindows()
