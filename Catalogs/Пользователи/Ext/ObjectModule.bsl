﻿
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	Если ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.ФизЛица") И НЕ ДанныеЗаполнения.ЭтоГруппа Тогда
		Наименование= ДанныеЗаполнения.Наименование;
		ФизЛицо		= ДанныеЗаполнения;
	КонецЕсли;
КонецПроцедуры

Процедура ПередУдалением(Отказ)
	Если Ссылка = Юзеры.ТекущийПользователь() Тогда
		ОбщегоНазначения.СообщитьОбОшибке("Попытка самоуничтожения", Отказ);
	КонецЕсли;
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	Если Ссылка.Пустая() Тогда
		Если ПустаяСтрока(Код) Тогда
			Код = СтрЗаменить(Наименование, " ", "-") + Строка(Новый УникальныйИдентификатор);
		КонецЕсли;
		Если НЕ ФизЛицо.Пустая() Тогда
			Запрос = Новый Запрос("ВЫБРАТЬ
			                      |	Пользователи.Ссылка
			                      |ИЗ
			                      |	Справочник.Пользователи КАК Пользователи
			                      |ГДЕ
			                      |	Пользователи.ФизЛицо = &ФизЛицо
			                      |	И Пользователи.Ссылка <> &Ссылка");
			Запрос.УстановитьПараметр("ФизЛицо",	ФизЛицо);
			Запрос.УстановитьПараметр("Ссылка",		Ссылка);
			Если Ссылка.Пустая() Тогда
				Запрос.Текст = "ВЫБРАТЬ
				               |	Пользователи.Ссылка
				               |ИЗ
				               |	Справочник.Пользователи КАК Пользователи
				               |ГДЕ
				               |	Пользователи.ФизЛицо = &ФизЛицо";
			КонецЕсли;
			Если НЕ Запрос.Выполнить().Пустой() Тогда
				ОбщегоНазначения.СообщитьОбОшибке("Ошибка заполнения реквизита Физ.лицо", Отказ);
			КонецЕсли;
		КонецЕсли;
	ИначеЕсли Ссылка.ПометкаУдаления <> ПометкаУдаления  И Ссылка = Юзеры.ТекущийПользователь() Тогда
		ОбщегоНазначения.СообщитьОбОшибке("Попытка самоуничтожения", Отказ);
	КонецЕсли;
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	//Код			= "";
	ФизЛицо		= Неопределено;
	//Комментарий	= "";
КонецПроцедуры
