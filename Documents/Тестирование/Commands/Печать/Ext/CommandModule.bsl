﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	Если ТипЗнч(ПараметрКоманды) = Тип("ДокументСсылка.Тестирование") Тогда
		РаботаСДиалогами.НапечататьДокумент(Тесты.ТестированиеНапечатать(ПараметрКоманды));
	КонецЕсли;
КонецПроцедуры
