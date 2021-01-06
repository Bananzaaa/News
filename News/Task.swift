//
//  Task.swift
//  News
//
//  Created by Ацкий Станислав on 05.01.2021.
//

/*
 Агрегатор новостной ленты из нескольких источников (например http://lenta.ru/rss и http://www.gazeta.ru/export/rss/lenta.xml - неудобный xml или json - https://newsapi.org/ с разными источниками)
 - Приложение должно отображать новости в одном списке, отсортированном по дате публикации, из двух и более источников
 - Приложения должно быть масштабируемо для добавления новых источников
 - Приложение должно указывать в новости ее источник
 - Новость должна иметь два режима отображения: обычный и расширенный. В обычном выводятся элементы: картинка, заголовок. В расширенном добавляется краткое описание новости.
 - Пометка о прочтении при открытии новости целиком.
 - Обновление по таймеру (выбор частоты обновления например можно вынести в настройки).
 - Настройки (например: частота обновления, включать/выключать источник новостей), с сохранением при перезапуске.
 - Использование БД для хранения новостей
 Основные требования:
 - Продуманная и масштабируемая структура проекта
 - Архитектура VIPER
 - Покрытие тестами
 */
