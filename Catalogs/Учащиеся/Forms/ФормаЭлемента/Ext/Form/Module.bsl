﻿
&НаКлиенте
Процедура ФизЛицоПриИзменении(Элемент)
	Если НЕ ПустаяСтрока(Объект.ФизЛицо) И (Объект.Ссылка.Пустая() Или ПустаяСтрока(Объект.Наименование)) Тогда
		Объект.Наименование = ОбщегоНазначения.ФИО(Объект.ФизЛицо);
	КонецЕсли;
КонецПроцедуры
