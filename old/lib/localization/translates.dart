class Translates {
  static Map<String, String> getTranslates(String langCode) {
    if (langCode == "uz") {
      return UzTranslates.getTranslate();
    }
    return RuTranslates.getTranslate();
  }
}

class UzTranslates {
  static Map<String, String> getTranslate() {
    Map<String, String> result = {};
    result.addAll(_gerDefault());
    result.addAll(_getLang());
    result.addAll(_getError());
    result.addAll(_getMain());
    result.addAll(_getSetting());
    result.addAll(_getSearchIndex());
    result.addAll(_getMedicineList());
    result.addAll(_getFilter());
    result.addAll(_getMedicineMarkList());
    result.addAll(_getMedicineItem());
    result.addAll(_getMedicineInstruction());
    result.addAll(_getAbout());
    return result;
  }

  static Map<String, String> _gerDefault() {
    return {
      "error": "xato",
      "cancel": "Yopish",
      "next": "Keyingi",
      "no_internet_connect": "Internetga ulanmagan",
      "unknown": "noma`lum",
      "please_wait": "Iltimos kuting",
      "internet_connection_error_title": "Ulanish amalga oshmadi",
      "internet_connection_error_message": "Iltimos, Internet aloqangizni tekshiring",
      "internet_connection_error_btn_positive": "Qayta urinib ko'rish",
      "internet_connection_error_btn_negative": "Chiqish",
      "hour": "%1s soat",
      "minute": "%1s minut",
      "hour_minute": "%1s soat %2s minut",
      "more": "Ko`proq",
      "presentation:next": "Keyingisi",
      "presentation:done": "Tugatish",
    };
  }

  static Map<String, String> _getLang() {
    return {
      "select_language": "Tilni tanlang",
      "ru": "Русский",
      "uz": "O`zbekcha",
    }.keyWithPrefix("lang:");
  }

  static Map<String, String> _getError() {
    return {
      "error_conection_fail": "Internet aloqasi yo`q (connection fail)",
      "error_conection_refused": "Internet aloqasi yo`q (connection refused)",
      "error_http_not_found": "Internet aloqasi yo`q (http not found)",
      "error_connection_timeout":
          "Internet tezligi juda past yoki Internet aloqasi yo`q (connection timeout)",
    }.keyWithPrefix("error:");
  }

  static Map<String, String> _getMain() {
    return {
      "medicine": "Dorilar",
      "pharmacy": "Dorixona (tez orada)",
      "medical_facilities": "Tibbiyot muassasalari (tez orada)",
      "setting": "Sozlash",
      "title": "Dori-darmonlarni, dorixonalarni va shifoxonalarni qidiring",
      "search_hint": "Nimani qidirmoqchisiz?",
      "about": "Haqida",
      "app_update_available": "Ilovada yangilanish mavjud",
      "update": "Yangilash",
    }.keyWithPrefix("main:");
  }

  static Map<String, String> _getSetting() {
    return {
      "change_lang": "Tilni o'zgartirish",
      "help": "Yordam",
      "interface": "Interfeys",
      "settings": "Sozlamalar",
      "about": "Haqida",
      "tutorial": "Qo'llanma",
      "dark_mode": "Tungi rejim",
    }.keyWithPrefix("setting:");
  }

  static Map<String, String> _getSearchIndex() {
    return {
      "search": "Nomi, MNN",
      "search_text": "Dori vositasini qidirish",
      "list_is_empty": "Ro'yxat bo'sh",
      "filter": "Filter",
      "syncing": "Sinxronizatsiya",
    }.keyWithPrefix("search_index:");
  }

  static Map<String, String> _getMedicineList() {
    return {
      "search": "Qidirish...",
      "search_by": "Qidiruv :",
      "search_by_name": "Nomi",
      "search_by_inn": "MNN",
      "reload": "Qayta yuklash",
      "with_recipe": "retsept bo'yicha",
      "with_out_recipe": "retseptsiz",
      "no_data_found": "Ma'lumot topilmadi",
      "price": "Cheklangan narxi: %1s so'm",
      "price_currency": "",
      "not_found_price": "Cheklangan narxi: o'rnatilmagan",
      "pharmacy_dispensing_conditions": "Dorixonalardan berish tartibi: ",
    }.keyWithPrefix("medicine_list_fragment:");
  }

  static Map<String, String> _getFilter() {
    return {
      "integer_text_field_hint": "Iltimos, raqamni kiriting",
      "string_text_field_hint": "Iltimos, matnni kiriting",
      "integer_range_from_hint": "dan",
      "integer_range_to_hint": "gacha",
      "clear_btn": "Bekor qilish",
      "apply_btn": "Qabo'l qilish",
    }.keyWithPrefix("filter:");
  }

  static Map<String, String> _getMedicineMarkList() {
    return {
      "mark_name": "Ism",
      "mark_inn": "MNN",
      "search_history": "Qidiruv tarixi",
      "show_more": "Ko'proq ko'rsatish",
      "warning": "Ogohlantirish",
      "delete_message": "O'chirishni xohlisizmi?",
      "yes": "Ha",
      "no": "Yo'q",
    }.keyWithPrefix("medicine_mark_list_fragment:");
  }

  static Map<String, String> _getMedicineItem() {
    return {
      "reload": "Qayta yuklash",
      "with_recipe": "retsept bo'yicha",
      "with_out_recipe": "retseptsiz",
      "no_data_found": "Ma'lumot topilmadi",
      "price": " so'm",
      "medicine_price": "%1s so'm",
      "analogs_count": "Analoglar (%1s)",
      "instructions": "Ko'rsatmalar",
      "marginal_price": "cheklangan narxi",
      "mnn": "MNN: ",
      "producer": "Ishlab chiqaruvchi: ",
      "not_found_price": "o'rnatilmagan",
      "medicine_marginal_price": "Cheklangan narxi: %1s",
      "show_all": "Barchasini ko'rish",
    }.keyWithPrefix("medicine_item:");
  }

  static Map<String, String> _getMedicineInstruction() {
    return {
      "reload": "Qayta yuklash",
      "mnn": "MNN: ",
      "producer": "Ishlab chiqaruvchi: ",
      "scope": "Qo'llanish sohasi",
      "storage": "Saqlash shartlari",
      "pharmacologic_action": "Farmakologik ta'siri",
      "atc_name": "Anatomik terapevtik kimyoviy tasnifi",
      "shelf_life": "Saqlash muddati",
      "opened_shelf_life": "Ochilgandan keyingi saqlash muddati",
      "spread_kind": "Dorixonalardan berilish tartibi",
      "with_recipe": "retsept bo'yicha",
      "with_out_recipe": "retseptsiz",
      "clinical_pharmacological_group": "Kliniko-Farmakologik guruhi",
      "pharmacotherapeutic_group": "Farmakoterapevtik guruhi",
      "color": "Rang",
      "taste": "Ta'm",
      "route_of_administration": "Qo'llash uslubi",
      "medicine_product": "Dori vositasi",
      "year": "%1s yil",
      "month": "%1s oy",
      "week": "%1s hafta",
      "day": "%1s kun",
      "no_data_found": "Ma'lumot topilmadi",
    }.keyWithPrefix("medicine_instruction:");
  }

  static Map<String, String> _getAbout() {
    return {
      "address": "100002, Toshkent sh., Olmazor tumani Ozod ko'chasi, K.Umarov tor ko'chasi, 16 uy",
      "phone": "+998 (71) 242-48-93",
      "fax": "+998 (71) 242-48-25",
      "site": "https://www.uzpharm-control.uz",
      "mail": "farmkomitet@minzdrav.uz",
      "address_text": "Manzil",
      "phone_text": "Telefon",
      "fax_text": "Faks",
      "site_text": "Web-sayt",
      "mail_text": "Elektron pochta",
    }.keyWithPrefix("about:");
  }
}

class RuTranslates {
  static Map<String, String> getTranslate() {
    Map<String, String> result = {};
    result.addAll(_gerDefault());
    result.addAll(_getLang());
    result.addAll(_getError());
    result.addAll(_getMain());
    result.addAll(_getSetting());
    result.addAll(_getSearchIndex());
    result.addAll(_getMedicineList());
    result.addAll(_getFilter());
    result.addAll(_getMedicineMarkList());
    result.addAll(_getMedicineItem());
    result.addAll(_getMedicineInstruction());
    result.addAll(_getAbout());
    return result;
  }

  static Map<String, String> _gerDefault() {
    return {
      "error": "ошибка",
      "cancel": "Закрыть",
      "next": "Далее",
      "no_internet_connect": "Нет соединения с интернетом",
      "unknown": "неизвестно",
      "please_wait": "Пожалуйста, подождите",
      "internet_connection_error_title": "Ошибка подключения",
      "internet_connection_error_message": "Пожалуйста, проверьте подключение к интернету",
      "internet_connection_error_btn_positive": "Попробуй снова",
      "internet_connection_error_btn_negative": "Выход",
      "hour": "%1s ч",
      "minute": "%1s мин",
      "hour_minute": "%1s ч %2s мин",
      "more": "еще",
      "presentation:next": "Далее",
      "presentation:done": "Готово",
    };
  }

  static Map<String, String> _getLang() {
    return {
      "select_language": "Выбрать язык",
      "ru": "Русский",
      "uz": "O`zbekcha",
    }.keyWithPrefix("lang:");
  }

  static Map<String, String> _getError() {
    return {
      "error_conection_fail": "Нет соединения с интернетом (connection fail)",
      "error_conection_refused": "Нет соединения с интернетом (connection refused)",
      "error_http_not_found": "Нет соединения с интернетом (http not found)",
      "error_connection_timeout":
          "Скорост интернет не поддерживается или нет интернета(connection timeout)",
    }.keyWithPrefix("error:");
  }

  static Map<String, String> _getMain() {
    return {
      "medicine": "Лекарства",
      "pharmacy": "Аптеки (скоро)",
      "medical_facilities": "Медицинские учереждения (скоро)",
      "setting": "Настройка",
      "title": "Поиск лекарств, аптек и больниц",
      "search_hint": "Что ищем?",
      "about": "О программе",
      "app_update_available": "Доступно обновление приложения",
      "update": "Обновить сейчас",
    }.keyWithPrefix("main:");
  }

  static Map<String, String> _getSetting() {
    return {
      "change_lang": "Изменить язык",
      "help": "Помощь",
      "interface": "Интерфейс",
      "settings": "Настройки",
      "about": "О программе",
      "dark_mode": "Темный режим",
      "tutorial": "Руководство",
    }.keyWithPrefix("setting:");
  }

  static Map<String, String> _getSearchIndex() {
    return {
      "search": "Название, МНН",
      "search_text": "Поиск лекарственного препарата",
      "list_is_empty": "Список пуст",
      "filter": "Фильтр",
      "syncing": "Синхронизация",
    }.keyWithPrefix("search_index:");
  }

  static Map<String, String> _getMedicineList() {
    return {
      "search": "Поиск..",
      "search_by": "Искать по:",
      "search_by_name": "Название",
      "search_by_inn": "МНН",
      "reload": "Перезагрузить",
      "with_recipe": "по рецепту",
      "with_out_recipe": "без рецепта",
      "no_data_found": "Данные не найдены",
      "price": "Предельная цена: %1s сум",
      "not_found_price": "Предельная цена: не установлена",
      "price_currency": " сум",
      "pharmacy_dispensing_conditions": "Условия отпуска из аптек: ",
    }.keyWithPrefix("medicine_list_fragment:");
  }

  static Map<String, String> _getFilter() {
    return {
      "integer_text_field_hint": "Пожалуйста, введите номер",
      "string_text_field_hint": "Пожалуйста, введите текст",
      "integer_range_from_hint": "от",
      "integer_range_to_hint": "до",
      "clear_btn": "Чисто",
      "apply_btn": "Применять",
    }.keyWithPrefix("filter:");
  }

  static Map<String, String> _getMedicineMarkList() {
    return {
      "mark_name": "Название",
      "mark_inn": "МНН",
      "search_history": "История поиска",
      "show_more": "Показать больше",
      "warning": "Предупреждение",
      "delete_message": "Вы хотели удалить?",
      "yes": "Да",
      "no": "Нет",
    }.keyWithPrefix("medicine_mark_list_fragment:");
  }

  static Map<String, String> _getMedicineItem() {
    return {
      "reload": "Перезагрузить",
      "with_recipe": "по рецепту",
      "with_out_recipe": "без рецепта",
      "no_data_found": "Данные не найдены",
      "price": " сум",
      "medicine_price": "%1s сум",
      "analogs_count": "Аналоги (%1s)",
      "instructions": "Инструкция",
      "marginal_price": "предельная цена",
      "mnn": "МНН: ",
      "producer": "Производитель: ",
      "not_found_price": "не установлена",
      "medicine_marginal_price": "Предельная цена: %1s",
      "show_all": "Показать все",
    }.keyWithPrefix("medicine_item:");
  }

  static Map<String, String> _getMedicineInstruction() {
    return {
      "reload": "Перезагрузить",
      "mnn": "МНН: ",
      "producer": "Производитель: ",
      "scope": "Область применения",
      "storage": "Условия хранения",
      "pharmacologic_action": "Фармакологическое действие",
      "atc_name": "Анатомо-терапевтическая химическая классификация",
      "shelf_life": "Срок годности",
      "opened_shelf_life": "Срок годности после вскрытия",
      "spread_kind": "Условия отпуска из аптек",
      "with_recipe": "по рецепту",
      "with_out_recipe": "без рецепта",
      "clinical_pharmacological_group": "Клиническая-Фармакологическая группа",
      "pharmacotherapeutic_group": "Фармакотерапевтическая группа",
      "color": "Цвет",
      "taste": "Вкус",
      "route_of_administration": "Способ введения",
      "medicine_product": "Лекарственное средство",
      "year": "%1s год",
      "month": "%1s месяц",
      "week": "%1s неделю",
      "day": "%1s день",
      "no_data_found": "Данные не найдены",
    }.keyWithPrefix("medicine_instruction:");
  }

  static Map<String, String> _getAbout() {
    return {
      "address": "100002, г.Ташкент, ул. Озод, проезд К.Умарова, 16.",
      "phone": "+998 (71) 242-48-93",
      "fax": "+998 (71) 242-48-25",
      "site": "https://www.uzpharm-control.uz",
      "mail": "farmkomitet@minzdrav.uz",
      "address_text": "Адрес",
      "phone_text": "Телефон",
      "fax_text": "Факс",
      "site_text": "Сайт",
      "mail_text": "Электронная почта",
    }.keyWithPrefix("about:");
  }
}

extension MapKeyPrefix on Map<String, String> {
  Map<String, String> keyWithPrefix(String prefix) {
    return this.map((key, value) => MapEntry("$prefix$key", value));
  }
}
