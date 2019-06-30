# encoding: utf-8

# Программа «Блокнот».
# Вывод версии программы.
VERSION = 0.2
puts  "Программа \"Блокнот\". Версия #{VERSION}."

# Этот код необходим только при использовании русских букв на Windows
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

# Подключаем класс Post и его детей: Memo, Link, Task
require_relative 'lib/post'
require_relative 'lib/memo'
require_relative 'lib/link'
require_relative 'lib/task'

# Поздороваемся с пользователем и просим у него, что он хочет создать.
puts 'Привет, я твой блокнот!'
puts
puts 'Что хотите записать в блокнот?'

# Запишем в переменную choices массив типов записей, которые можно создать,
# вызвав у класса Post метод post_types (статический метод).
choices = Post.post_types

# Для начала цикла запишем в переменную choice (куда позже будем складывать
# выбор пользователя) значение -1.
choice = -1

# Пока юзер не выбрал правильно (от 0 до длины массива вариантов), спрашиваем
# у него число и выводим список возможных вариантов для записи.
until choice >= 0 && choice < choices.size
  choices.each_with_index do |type, index|
    puts "\t#{index}. #{type}"
  end

  # Запишем выбор пользователя в переменную choice
  choice = gets.to_i
end

# Создаем экземпляр выбранного класса.
entry = Post.create(choice)

# Просим пользователя ввести пост (каким бы он ни был)
entry.read_from_console

# Сохраняем пост в файл
entry.save

# Сообщаем пользователю о том, что его запись сохранена в файл.
puts 'Ваша запись сохранена!'
