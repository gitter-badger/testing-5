﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Справочники.Уровни.НайтиПоКоду("1").Пустая() Тогда
		УчебныйПроцесс.УровниЗаполнить();
	КонецЕсли;
КонецПроцедуры
