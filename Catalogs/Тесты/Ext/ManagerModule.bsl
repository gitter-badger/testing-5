﻿
Процедура ОбработкаПолученияФормы(ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка)
	Если НРег(ВидФормы) = "формавыбора" Тогда
		Параметры.Вставить("ТолькоПросмотр", Истина);
		Параметры.Вставить("Отбор", Новый Структура("ПометкаУдаления", Ложь));
		Параметры.Вставить("Отбор", Новый Структура("Ссылка", Тесты.ТестыДоступныеПолучить()));
	КонецЕсли;
КонецПроцедуры
