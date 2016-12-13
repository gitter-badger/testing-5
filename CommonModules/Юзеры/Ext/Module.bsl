﻿
Функция ТекущийПользователь() Экспорт
	Возврат ПараметрыСеанса.ТекущийПользователь;
КонецФункции

Функция Гость()
	//Объект = ПользователиИнформационнойБазы.НайтиПоИмени("Guest");
	//Если Объект = Неопределено Тогда
	//	Объект = ПользователиИнформационнойБазы.СоздатьПользователя();
	//	Объект.Имя						= "Guest";
	//	Объект.ПолноеИмя				= "Guest";
	//	Объект.ПоказыватьВСпискеВыбора	= Ложь;
	//	Объект.ЗапрещеноИзменятьПароль	= Истина;
	//	Объект.РежимЗапуска				= РежимЗапускаКлиентскогоПриложения.УправляемоеПриложение;
	//	//Объект.АутентификацияОС			= Истина;
	//	Объект.Роли.Добавить("Гость");
	//	Объект.Записать();
	//КонецЕсли;
	Ссылка = Справочники.Пользователи.НайтиПоНаименованию("Guest", Истина);
	Если Ссылка.Пустая() Тогда
		Объект = Справочники.Пользователи.СоздатьЭлемент();
		Объект.Наименование	= "Guest";
		Объект.Код			= "Guest";
		Объект.Записать();
		Ссылка	= Объект.Ссылка;
	КонецЕсли;
	Возврат Ссылка;
КонецФункции

Процедура ТекущийПользовательОчисть() Экспорт
	ПараметрыСеанса.ТекущийПользователь = Справочники.Пользователи.ПустаяСсылка();
КонецПроцедуры

Процедура УстановитьПараметрСеансаТекущийПользователь(Знач ИмяПользователя="") Экспорт
	Если ПустаяСтрока(ИмяПользователя) Тогда
		ИмяПользователя = ПользователиИнформационнойБазы.ТекущийПользователь().Имя;
		//ПараметрыСеанса.ТекущийПользователь = Гость();
	КонецЕсли;
	ПараметрыСеанса.ТекущийПользователь = Справочники.Пользователи.НайтиПоНаименованию(ИмяПользователя, Истина);
	
	//ТекущийПользователь = ПользователиИнформационнойБазы.ТекущийПользователь();
	//Пользователь = ПользовательНайти(ТекущийПользователь);
	//Если ЗначениеЗаполнено(Пользователь) Тогда
	//	Если Пользователь.ПометкаУдаления Тогда
	//		ТекущийПользователь.АутентификацияOpenID		= Ложь;
	//		ТекущийПользователь.АутентификацияОС			= Ложь;
	//		ТекущийПользователь.ПользовательОС				= "xxx";
	//		ТекущийПользователь.АутентификацияСтандартная	= Ложь;
	//		ТекущийПользователь.ПоказыватьВСпискеВыбора		= Ложь;
	//		
	//		ТекущийПользователь.Записать();
	//	Иначе
	//        ПараметрыСеанса.ТекущийПользователь = Пользователь;
	//	КонецЕсли;
	//Иначе
	//	//Пользователь = ПользовательСоздать(Новый Структура("Код,Наименование", ТекущийПользователь.УникальныйИдентификатор, ТекущийПользователь.ПолноеИмя));
	//	//Если ЗначениеЗаполнено(Пользователь) Тогда
	//	//	ПараметрыСеанса.ТекущийПользователь = Пользователь;
	//	//КонецЕсли;
	//КонецЕсли;
КонецПроцедуры

//Функция ЕстьПравоАдминистрирования(Пользователь)
//	Ответ = Ложь;
//	Для Каждого ТекЭлемент Из Пользователь.Роли Цикл
//		Если ТекЭлемент.Имя = "Администратор" Или ТекЭлемент.Имя = "ПолныйДоступ" Тогда
//			Ответ = Истина;
//			Прервать;
//		КонецЕсли;
//	КонецЦикла;
//	Возврат Ответ;
//	//РольДоступна("Администратор")
//КонецФункции

Функция УчетнаяЗаписьГостевая() Экспорт
	Возврат (ТекущийПользователь() = Гость());
КонецФункции

Функция Фаталити() Экспорт
	Возврат (ПользователиИнформационнойБазы.ПолучитьПользователей().Количество() = 0);
КонецФункции

Функция ПользовательНайти(Знач Пользователь) Экспорт
    Запрос = Новый Запрос("ВЫБРАТЬ
                          |	Пользователи.Ссылка КАК Пользователь,
                          |	Пользователи.Наименование КАК Наименование
                          |ИЗ
                          |	Справочник.Пользователи КАК Пользователи
                          |ГДЕ
                          |	Пользователи.Код = &Код
                          |	И Пользователи.ЭтоГруппа = ЛОЖЬ");
	Если ТипЗнч(Пользователь) = Тип("СправочникСсылка.ФизЛица") Тогда
		Запрос.Текст = "ВЫБРАТЬ
		                      |	Пользователи.Ссылка КАК Пользователь
		                      |ИЗ
		                      |	Справочник.Пользователи КАК Пользователи
		                      |ГДЕ
		                      |	Пользователи.ФизЛицо = &ФизЛицо
		                      |	И Пользователи.ЭтоГруппа = ЛОЖЬ";
		Запрос.УстановитьПараметр("ФизЛицо",	?(ЗначениеЗаполнено(Пользователь), Пользователь, Неопределено));
    	Выборка = Запрос.Выполнить().Выбрать();
	Иначе
	    Запрос.Параметры.Вставить("Код",	Лев(Пользователь.УникальныйИдентификатор, 36));
		Результат = Запрос.Выполнить();
		Если Результат.Пустой() Тогда
		    Запрос.Параметры.Вставить("Код",	Лев(Пользователь.Имя, 36));
			Результат = Запрос.Выполнить();
			Если Результат.Пустой() Тогда
				Запрос.Текст = "ВЫБРАТЬ
                          |	Пользователи.Ссылка КАК Пользователь,
                          |	Пользователи.Наименование КАК Наименование
                          |ИЗ
                          |	Справочник.Пользователи КАК Пользователи
                          |ГДЕ
                          |	Пользователи.Наименование = &Код
                          |	И Пользователи.ЭтоГруппа = ЛОЖЬ";
			    Запрос.Параметры.Вставить("Код",	СокрЛП(Пользователь.Имя));
		    	Выборка = Запрос.Выполнить().Выбрать();
			Иначе
				Выборка = Результат.Выбрать();
			КонецЕсли;
		Иначе
			Выборка = Результат.Выбрать();
		КонецЕсли;
	КонецЕсли;
	Возврат ?(Выборка.Следующий(), Выборка.Пользователь, Справочники.Пользователи.ПустаяСсылка());
КонецФункции

Функция ПользовательСоздать(Структура) Экспорт
	//УстановитьПривилегированныйРежим(Истина);
	Ответ = Справочники.Пользователи.ПустаяСсылка();
	Пользователь = Справочники.Пользователи.СоздатьЭлемент();
	ЗаполнитьЗначенияСвойств(Пользователь, Структура);
	Попытка
        Пользователь.Записать();
		Ответ = Пользователь.Ссылка;
	Исключение
		Сообщить(ОписаниеОшибки());
	КонецПопытки;
	Возврат Ответ;
КонецФункции

Функция Ключник(Знач Имя, Знач Слово) Экспорт
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	Пользователи.Ссылка КАК Ссылка,
	                      |	Пользователи.ПометкаУдаления КАК ПометкаУдаления
	                      |ИЗ
	                      |	Справочник.Пользователи КАК Пользователи
	                      |ГДЕ
	                      |	Пользователи.Наименование = &Имя");
	Запрос.УстановитьПараметр("Имя",	Имя);
	//Запрос.УстановитьПараметр("Слово",	Слово);
	Выборка = Запрос.Выполнить().Выбрать();
	Ответ = Ложь;
	Если Выборка.Следующий() Тогда
		Если Выборка.ПометкаУдаления Тогда
			Сообщить("Пользователь заблокирован, обратитесь к администратору");
		Иначе
			Ответ = Истина;
		КонецЕсли;
	Иначе
		Сообщить("Пользователь не найден или пароль введен не верно");
	КонецЕсли;
	Возврат Ответ;
КонецФункции

Функция ПервыйЗапуск(ФизЛицо) Экспорт
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗЛИЧНЫЕ
	                      |	Результаты.ФизЛицо КАК Ссылка
	                      |ИЗ
	                      |	РегистрСведений.РезультатыТестирования.СрезПоследних(, ФизЛицо = &ФизЛицо) КАК Результаты");
	Запрос.УстановитьПараметр("ФизЛицо", ?(ТипЗнч(ФизЛицо) = Тип("СправочникСсылка.Пользователи"), ФизЛицо.ФизЛицо, ФизЛицо));
	Возврат Запрос.Выполнить().Пустой();
КонецФункции
