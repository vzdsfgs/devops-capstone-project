FROM python:3.9-slim

# Создаем рабочую директорию и устанавливаем зависимости
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем содержимое приложения
COPY service/ ./service/

# Создаем пользователя theia и переключаемся на него
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Открываем порт 8080 и запускаем gunicorn
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
