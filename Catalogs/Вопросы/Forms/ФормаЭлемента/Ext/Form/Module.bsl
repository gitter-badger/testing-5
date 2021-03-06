﻿
Процедура ОтветыЗагрузить()
	Если НЕ Элементы.ГруппаОтветы.ТолькоПросмотр Тогда
		Ответы = Тесты.ОтветыПоВопросу(Объект.Ссылка);
		НомерСтроки = 0;
		Для Каждого тСтрока Из Ответы Цикл
			НомерСтроки = НомерСтроки + 1;
			Если НомерСтроки = 1 Тогда
				Ответ1	= тСтрока.Ответ;
				Вес1	= тСтрока.Вес;
				Если тСтрока.ОтветИспользован Тогда
					Элементы.Ответ1.ТолькоПросмотр	= Истина;
					Элементы.Вес1.ТолькоПросмотр	= Истина;
				КонецЕсли;
			ИначеЕсли НомерСтроки = 2 Тогда
				Ответ2	= тСтрока.Ответ;
				Вес2	= тСтрока.Вес;
				Если тСтрока.ОтветИспользован Тогда
					Элементы.Ответ2.ТолькоПросмотр	= Истина;
					Элементы.Вес2.ТолькоПросмотр	= Истина;
				КонецЕсли;
			ИначеЕсли НомерСтроки = 3 Тогда
				Ответ3	= тСтрока.Ответ;
				Вес3	= тСтрока.Вес;
				Если тСтрока.ОтветИспользован Тогда
					Элементы.Ответ3.ТолькоПросмотр	= Истина;
					Элементы.Вес3.ТолькоПросмотр	= Истина;
				КонецЕсли;
			ИначеЕсли НомерСтроки = 4 Тогда
				Ответ4	= тСтрока.Ответ;
				Вес4	= тСтрока.Вес;
				Если тСтрока.ОтветИспользован Тогда
					Элементы.Ответ4.ТолькоПросмотр	= Истина;
					Элементы.Вес4.ТолькоПросмотр	= Истина;
				КонецЕсли;
			ИначеЕсли НомерСтроки = 5 Тогда
				Ответ5	= тСтрока.Ответ;
				Вес5	= тСтрока.Вес;
				Если тСтрока.ОтветИспользован Тогда
					Элементы.Ответ5.ТолькоПросмотр	= Истина;
					Элементы.Вес5.ТолькоПросмотр	= Истина;
				КонецЕсли;
			ИначеЕсли НомерСтроки = 6 Тогда
				Ответ6	= тСтрока.Ответ;
				Вес6	= тСтрока.Вес;
				Если тСтрока.ОтветИспользован Тогда
					Элементы.Ответ6.ТолькоПросмотр	= Истина;
					Элементы.Вес6.ТолькоПросмотр	= Истина;
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "Вопросы" И (Параметр = Объект.Ссылка Или ТипЗнч(Параметр) = ТипЗнч(Объект.Ссылка) И НЕ ЗначениеЗаполнено(Параметр)) Тогда
		ОтветыЗагрузить();
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Юзеры.УчетнаяЗаписьГостевая() Тогда
		Отказ = Истина;
	ИначеЕсли Объект.Владелец.Пустая() Тогда
		Отказ = Истина;
	ИначеЕсли Объект.Ссылка.Пустая() Тогда
		Если Объект.Код = 0 Тогда
			Объект.Код = Тесты.ПолучениеНовогоКода(Объект.Владелец);
		КонецЕсли;
		Элементы.ГруппаОтветы.ТолькоПросмотр = Истина;
	Иначе
		Если Тесты.ВопросИспользован(Объект.Ссылка) Тогда
			Элементы.Наименование.ТолькоПросмотр = Истина;
		КонецЕсли;
		ОтветыЗагрузить();
	КонецЕсли;
	//Параметры.ЗначенияЗаполнения
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	Оповестить("Вопросы", Объект.Владелец);
	Если Элементы.ГруппаОтветы.ТолькоПросмотр Тогда
		Элементы.ГруппаОтветы.ТолькоПросмотр = Ложь;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОтветНачалоВыбора(ОтветПараметры, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	ОтветФорма = Неопределено;
	Если Объект.Ссылка.Пустая() Тогда
	ИначеЕсли ЗначениеЗаполнено(ОтветПараметры.Ответ) Тогда
		ОтветФорма = ПолучитьФорму("Справочник.ВариантыОтветов.ФормаОбъекта", Новый Структура("Ключ", ОтветПараметры.Ответ), ЭтаФорма);
	Иначе
		ОтветФорма = ПолучитьФорму("Справочник.ВариантыОтветов.ФормаОбъекта", Новый Структура("ЗначенияЗаполнения", Новый Структура("Владелец,Вес", Объект.Ссылка, ОтветПараметры.Вес)), ЭтаФорма);
	КонецЕсли;
	Если ТипЗнч(ОтветФорма) = Тип("УправляемаяФорма") Тогда
		ОтветФорма.Открыть();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Ответ1НачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ОтветНачалоВыбора(Новый Структура("Ответ,Вес", Ответ1, Вес1), СтандартнаяОбработка)
КонецПроцедуры

&НаКлиенте
Процедура Ответ2НачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ОтветНачалоВыбора(Новый Структура("Ответ,Вес", Ответ2, Вес2), СтандартнаяОбработка)
КонецПроцедуры

&НаКлиенте
Процедура Ответ3НачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ОтветНачалоВыбора(Новый Структура("Ответ,Вес", Ответ3, Вес3), СтандартнаяОбработка)
КонецПроцедуры

&НаКлиенте
Процедура Ответ4НачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ОтветНачалоВыбора(Новый Структура("Ответ,Вес", Ответ4, Вес4), СтандартнаяОбработка)
КонецПроцедуры

&НаКлиенте
Процедура Ответ5НачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ОтветНачалоВыбора(Новый Структура("Ответ,Вес", Ответ5, Вес5), СтандартнаяОбработка)
КонецПроцедуры

&НаКлиенте
Процедура Ответ6НачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ОтветНачалоВыбора(Новый Структура("Ответ,Вес", Ответ6, Вес6), СтандартнаяОбработка)
КонецПроцедуры

&НаКлиенте
Процедура Ответ1Открытие(Элемент, СтандартнаяОбработка)
	ОтветНачалоВыбора(Новый Структура("Ответ,Вес", Ответ1, Вес1), СтандартнаяОбработка)
КонецПроцедуры

&НаКлиенте
Процедура Ответ2Открытие(Элемент, СтандартнаяОбработка)
	ОтветНачалоВыбора(Новый Структура("Ответ,Вес", Ответ2, Вес2), СтандартнаяОбработка)
КонецПроцедуры

&НаКлиенте
Процедура Ответ3Открытие(Элемент, СтандартнаяОбработка)
	ОтветНачалоВыбора(Новый Структура("Ответ,Вес", Ответ3, Вес3), СтандартнаяОбработка)
КонецПроцедуры

&НаКлиенте
Процедура Ответ4Открытие(Элемент, СтандартнаяОбработка)
	ОтветНачалоВыбора(Новый Структура("Ответ,Вес", Ответ4, Вес4), СтандартнаяОбработка)
КонецПроцедуры

&НаКлиенте
Процедура Ответ5Открытие(Элемент, СтандартнаяОбработка)
	ОтветНачалоВыбора(Новый Структура("Ответ,Вес", Ответ5, Вес5), СтандартнаяОбработка)
КонецПроцедуры

&НаКлиенте
Процедура Ответ6Открытие(Элемент, СтандартнаяОбработка)
	ОтветНачалоВыбора(Новый Структура("Ответ,Вес", Ответ6, Вес6), СтандартнаяОбработка)
КонецПроцедуры
