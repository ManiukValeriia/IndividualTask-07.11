require 'fileutils'

# Функція для видалення порожніх файлів у вказаній папці
def delete_empty_files(folder_path)
  unless Dir.exist?(folder_path)
    puts "Папка #{folder_path} не існує."
    return
  end

  empty_files = []

  # Перебір усіх файлів у папці
  Dir.foreach(folder_path) do |file|
    next if file == '.' || file == '..' # Пропускаємо спеціальні записи

    file_path = File.join(folder_path, file)
    if File.file?(file_path) && File.zero?(file_path) # Перевірка на порожній файл
      empty_files << file_path
    end
  end

  if empty_files.empty?
    puts "У папці #{folder_path} немає порожніх файлів."
  else
    empty_files.each do |file_path|
      File.delete(file_path)
      puts "Видалено порожній файл: #{file_path}"
    end
    puts "Всього видалено #{empty_files.size} порожніх файл(ів)."
  end
end

# Створення тестової папки з файлами
def setup_test_folder
  folder_path = "test_folder"
  Dir.mkdir(folder_path) unless Dir.exist?(folder_path)

  # Створення файлів
  File.write("#{folder_path}/file1.txt", "")  # Порожній файл
  File.write("#{folder_path}/file2.txt", "Цей файл містить дані.")  # Файл з даними
  File.write("#{folder_path}/file3.log", "")  # Порожній файл

  folder_path
end

# Використання утиліти
test_folder = setup_test_folder
puts "Файли створені у папці #{test_folder}. Запуск утиліти..."

delete_empty_files(test_folder)
