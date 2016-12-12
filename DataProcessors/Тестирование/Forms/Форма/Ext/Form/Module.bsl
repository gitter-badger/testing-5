﻿
Процедура ДокЗаписать()
	Если Шаг > 6 И НЕ ЗначениеЗаполнено(ДокТестирование) И НЕ Юзеры.УчетнаяЗаписьГостевая() Тогда
		//УстановитьПривилегированныйРежим(Истина);
		
		Док = Документы.Тестирование.СоздатьДокумент();
		//Док.Дата				= Объект.Дата;
		//Док.Учащийся			= Объект.Учащийся;
		//Док.Тест				= Объект.Тест;
		//Док.Оценка				= Объект.Оценка;
		//Док.ЗатраченоВремени	= Объект.ЗатраченоВремени;
		//Док.Комментарий			= СокрЛП(Объект.Комментарий);
		ЗаполнитьЗначенияСвойств(Док, Объект);
		
		Док.Вопросы.Загрузить(Объект.Вопросы.Выгрузить());
		Док.Ответы.Загрузить(Объект.Ответы.Выгрузить());
		Док.Записать(РежимЗаписиДокумента.Проведение);
		
		ДокТестирование = Док.Ссылка;
	КонецЕсли;
КонецПроцедуры

Процедура ТестДоступен()
	Если НЕ Тесты.ТестДоступен(Объект.Тест) Тогда
		Сообщить("Данный тест не доступен." + Строка(Объект.Тест));
		Объект.Тест = Неопределено;
	КонецЕсли;
КонецПроцедуры

Процедура ВопросыОтветыПолучить()
	Тесты.ВопросыОтветыПолучить(Объект.Тест, Объект.Вопросы, Объект.Ответы);
	Элементы.ХодВыполнения.МаксимальноеЗначение = Объект.Вопросы.Количество();
	
	Таймер	= Объект.Тест.ПродолжительностьТестирования * 60;
	Если НЕ Объект.Тест.РазрешитьПеремещения Тогда
		Элементы.ПредыдущийВопрос.Видимость	= Ложь;
		Элементы.СледующийВопрос.Видимость	= Ложь;
	КонецЕсли;
КонецПроцедуры

Процедура ОтветыОбновить()
	ВопросТекст		= ТекущийВопрос.Наименование;
	
	ОтветыКнопки = Новый Массив;
	ОтветыКнопки.Добавить(Элементы.Ответ1);
	ОтветыКнопки.Добавить(Элементы.Ответ2);
	ОтветыКнопки.Добавить(Элементы.Ответ3);
	ОтветыКнопки.Добавить(Элементы.Ответ4);
	ОтветыКнопки.Добавить(Элементы.Ответ5);
	ОтветыКнопки.Добавить(Элементы.Ответ6);
	Для Каждого текЭлемент Из ОтветыКнопки Цикл
		текЭлемент.Видимость	= Ложь;
		текЭлемент.Заголовок	= "";
	КонецЦикла;
	//НомерСтроки = 0;
	//Для Каждого тСтрока Из Объект.Ответы Цикл
	//	Если тСтрока.Вопрос = ТекущийВопрос Тогда
	//		Ответы[НомерСтроки].Видимость	= Истина;
	//		Ответы[НомерСтроки].Заголовок	= тСтрока.Наименование;
	//		
	//		НомерСтроки = НомерСтроки + 1;
	//	КонецЕсли;
	//КонецЦикла;
	НомерСтроки = 0;
	ТекОтветы = Объект.Ответы.НайтиСтроки(Новый Структура("Вопрос", ТекущийВопрос));
	Для Каждого ТекЭлемент Из ТекОтветы Цикл
		ОтветыКнопки[НомерСтроки].Видимость	= Истина;
		ОтветыКнопки[НомерСтроки].Заголовок	= ТекЭлемент.Наименование;
		
		НомерСтроки = НомерСтроки + 1;
	КонецЦикла;
КонецПроцедуры
	
Функция ВопросСледующий(Вперед=Истина)
	ВопросСледующий = Неопределено;
	Если ЗначениеЗаполнено(ТекущийВопрос) Тогда
		НомерВопроса	= 0;
		Для Каждого ТекСтрока Из Объект.Вопросы Цикл
			Если Вперед Тогда
				Если НомерВопроса > 0 Тогда
					ВопросСледующий = ТекСтрока.Вопрос;
					Прервать;
				ИначеЕсли ТекСтрока.Вопрос = ТекущийВопрос Тогда
					НомерВопроса	= ТекСтрока.НомерСтроки;
				КонецЕсли;
			Иначе
				Если ТекСтрока.Вопрос = ТекущийВопрос Тогда
					Если НомерВопроса > 0 Тогда
						Прервать;
					КонецЕсли;
				ИначеЕсли ТекСтрока.Вопрос <> ТекущийВопрос И НЕ ЗначениеЗаполнено(ТекСтрока.Ответ) Тогда
					НомерВопроса	= ТекСтрока.НомерСтроки;
					ВопросСледующий	= ТекСтрока.Вопрос;
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
		//Если НомерВопроса = 0 Тогда
		//КонецЕсли;
	КонецЕсли;
	Если НЕ ЗначениеЗаполнено(ВопросСледующий) Тогда
		Для Каждого ТекСтрока Из Объект.Вопросы Цикл
			Если НЕ ЗначениеЗаполнено(ТекСтрока.Ответ) Тогда
				ВопросСледующий = ТекСтрока.Вопрос;
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	Возврат ВопросСледующий;
КонецФункции

Процедура Отвечаю(НомерОтвета)
	ВариантыОтветов = Объект.Ответы.НайтиСтроки(Новый Структура("Вопрос,Код", ТекущийВопрос, НомерОтвета));
	Для Каждого ТекЭлемент Из ВариантыОтветов Цикл
		Для Каждого ТекСтрока Из Объект.Вопросы Цикл
			Если ТекСтрока.Вопрос = ТекущийВопрос Тогда
				ТекСтрока.Ответ		= ТекЭлемент.Ответ;
				ТекСтрока.Результат	= ТекЭлемент.Вес;
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	ХодВыполнения		= ХодВыполнения + 1;
	ВопросЗадать();
КонецПроцедуры

Процедура Оценить()
	Объект.ЗатраченоВремени	= Окр(?(ОбратныйОтсчетВремени, Элементы.Таймер.МаксимальноеЗначение - Таймер, Таймер) / 60);
	Если Объект.Тест.ОцениватьРезультат Тогда
		Результат		= Объект.Вопросы.Итог("Результат");
		Объект.Оценка	= Тесты.Оценить(Объект.Тест, Результат);
		Если ПустаяСтрока(Объект.Оценка.Комментарий) Тогда
			Элементы.ОценкаКомментарий.Видимость	= Ложь;
		КонецЕсли;
	Иначе
		Элементы.Оценка.Видимость				= Ложь;
		Элементы.ОценкаКомментарий.Видимость	= Ложь;
	КонецЕсли;
КонецПроцедуры

Процедура ВопросЗадать()
	Если Шаг = 1 Тогда
		ТекущийВопрос	= ВопросСледующий();
		Если НЕ ЗначениеЗаполнено(ТекущийВопрос) Тогда
			Шаг = 9;
		КонецЕсли;
	КонецЕсли;
	Если Шаг = 1 Тогда
		ОтветыОбновить();
	Иначе
		Оценить();
		ДокЗаписать();
		ЭкранОбновить();
	КонецЕсли;
КонецПроцедуры

Процедура ЭкранОбновить()
	Элементы.Шаг0.Видимость	= (Шаг = 0);
	Элементы.Шаг1.Видимость	= (Шаг = 1);
	Элементы.Шаг9.Видимость	= (Шаг > 6);
КонецПроцедуры

&НаКлиенте
Процедура КаунтДаун()
	Если Шаг = 1 Тогда
		Таймер = ?(ОбратныйОтсчетВремени, Элементы.Таймер.МаксимальноеЗначение - (ТекущаяДата() - ВремяСтарта), ТекущаяДата() - ВремяСтарта);
		Если ?(ОбратныйОтсчетВремени, Таймер <= 0, Таймер >= Элементы.Таймер.МаксимальноеЗначение) Тогда
			ОтключитьОбработчикОжидания("КаунтДаун");
			
			Элементы.ВремяИстекло.Видимость	= Истина;
			Шаг	= 8;
			ВопросЗадать();
		КонецЕсли;
	ИначеЕсли Шаг > 6 Тогда
		ОтключитьОбработчикОжидания("КаунтДаун");
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Начать(Команда=Неопределено)
	Если Объект.Тест.Пустая() Тогда
		Сообщить("Выберите тест");
	//ИначеЕсли Юзеры.УчетнаяЗаписьГостевая() Тогда
	//	
	//ИначеЕсли Объект.Учащийся.Пустая() Тогда
	//	Сообщить("Не указан учащийся");
	Иначе
		Заголовок = Объект.Тест;
		ВопросыОтветыПолучить();
		
		Шаг = 1;
		ЭкранОбновить();
		ВопросЗадать();
		Если Таймер > 0 Тогда
			Элементы.ЗатраченоВремени.Видимость		= Истина;
			Элементы.Таймер.Видимость				= Истина;
			Элементы.Таймер.МаксимальноеЗначение	= Таймер;
			ПодключитьОбработчикОжидания("КаунтДаун", Тесты.ИнтервалПолучить(Элементы.Таймер.МаксимальноеЗначение));
			Если НЕ ОбратныйОтсчетВремени Тогда
				Таймер									= 0;
			КонецЕсли;
		КонецЕсли;
		ВремяСтарта	= ТекущаяДата();
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Объект.Учащийся.Пустая() Тогда
		Если Юзеры.УчетнаяЗаписьГостевая() Тогда
			Объект.Пользователь	= Юзеры.ТекущийПользователь();
		ИначеЕсли Юзеры.ТекущийПользователь().ФизЛицо.Пустая() Тогда
			ОбщегоНазначения.СообщитьОбОшибке("Ошибка создания", Отказ);
		Иначе
			Объект.Пользователь	= Юзеры.ТекущийПользователь();
			Объект.Учащийся		= Юзеры.ТекущийПользователь().ФизЛицо;
		КонецЕсли;
	КонецЕсли;
	Объект.Дата		= ТекущаяДата();
	ВремяИстекло	= "Время теста истекло";
	ЭкранОбновить();
	
	ОбратныйОтсчетВремени	= Халк.ОбратныйОтсчетВремениПриТестировании();
	
	Если Параметры.Свойство("Тест") Тогда
		Объект.Тест	= Параметры.Тест;
		ТестДоступен();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	//Если ЗначениеЗаполнено(Объект.Тест) Тогда
	//	Начать();
	//КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТестПриИзменении(Элемент)
	ТестДоступен();
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	Если Шаг = 1 Тогда
		#Если ВебКлиент Тогда
			ОбщегоНазначения.СообщитьОбОшибке("Тест не был завершен", Отказ);
		#Иначе
			Если Вопрос("Вы действительно хотите прервать тестирование?", РежимДиалогаВопрос.ОКОтмена, 600, КодВозвратаДиалога.Отмена, , КодВозвратаДиалога.ОК) = КодВозвратаДиалога.Отмена Тогда
				Отказ = Истина;
			КонецЕсли;
		#КонецЕсли
		Если Отказ Тогда
			Шаг = 7;
			ВопросЗадать();
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Ответ1(Команда)
	Отвечаю(1);
КонецПроцедуры

&НаКлиенте
Процедура Ответ2(Команда)
	Отвечаю(2);
КонецПроцедуры

&НаКлиенте
Процедура Ответ3(Команда)
	Отвечаю(3);
КонецПроцедуры

&НаКлиенте
Процедура Ответ4(Команда)
	Отвечаю(4);
КонецПроцедуры

&НаКлиенте
Процедура Ответ5(Команда)
	Отвечаю(5);
КонецПроцедуры

&НаКлиенте
Процедура Ответ6(Команда)
	Отвечаю(6);
КонецПроцедуры

&НаКлиенте
Процедура ПредыдущийВопрос(Команда)
	ТекущийВопрос	= ВопросСледующий(Ложь);
	ОтветыОбновить();
КонецПроцедуры

&НаКлиенте
Процедура СледующийВопрос(Команда)
	ТекущийВопрос	= ВопросСледующий();
	ОтветыОбновить();
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	ДокЗаписать();
КонецПроцедуры

&НаКлиенте
Процедура ВопросТекстОткрытие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

&НаКлиенте
Процедура ОценкаОткрытие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

Функция ОтчетПолучить()
	//Новый Структура("Дата,Тест,Оценка,ЗатраченоВремени,Комментарий", Объект.Дата, Объект.Тест, Объект.Оценка, Объект.ЗатраченоВремени, Объект.Комментарий)
	ДокЗаписать();
	Если ЗначениеЗаполнено(ДокТестирование) Тогда
		Возврат Тесты.ТестированиеНапечатать(ДокТестирование);
	Иначе
		Возврат Тесты.ТестированиеНапечатать2(Объект, Объект.Вопросы, Объект.Ответы);
	КонецЕсли;
КонецФункции

&НаКлиенте
Процедура Печать(Команда)
	РаботаСДиалогами.НапечататьДокумент(ОтчетПолучить());
КонецПроцедуры
