﻿
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	Если ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.ФизЛица") И НЕ ДанныеЗаполнения.ЭтоГруппа Тогда
		Наименование= ДанныеЗаполнения.Наименование;
		ФизЛицо		= ДанныеЗаполнения;
	КонецЕсли;
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	Если ЗначениеЗаполнено(ФизЛицо) Тогда
	КонецЕсли;
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	ФизЛицо	= Неопределено;
КонецПроцедуры
