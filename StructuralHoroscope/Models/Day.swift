//
//  DayStruct.swift
//  StructuralHoroscope
//
//  Created by sihtmark on 31.07.2023.
//

import Foundation

struct DayStruct: Identifiable, Codable, Hashable {
    var id = UUID()
    let date: Date
    let signs: [AnnualEnum: DayType]
    
    var dateComponents: DateComponents {
        var dateComponents = Calendar.current.dateComponents(
            [.month,
             .day,
             .year],
            from: date)
        dateComponents.timeZone = TimeZone.current
        dateComponents.calendar = Calendar(identifier: .gregorian)
        return dateComponents
    }
}

struct DayType: Codable, Hashable, Identifiable {
    var id = UUID()
    let title: String
    let emoji: String
    let text: String?
}

let days = [firstDay, secondDay, thirdDay, fourthDay, fifthDay, sixthDay, seventhDay, eighthDay, ninthDay, tenthDay, eleventhDay, twelveDay]

let coloredDays = [green, red, blue, yellow, orange]

let mindDays = [easier, harder, rest, hangOut]

let green = DayType(
    title: "Зеленый",
    emoji: "💚",
    text: "Полный газ, искать удачи, возможно все, рискуй, ищи высшего вдохновения!"
)

let red = DayType(
    title: "Красный",
    emoji: "❤️",
    text: "Переломный день, ходу нет, надо каяться (только искренне!), просить прощения, улучшать карму"
)

let blue = DayType(
    title: "Синий",
    emoji: "💙",
    text: "Расслабление полнейшее, эйфория и самодовольство"
)

let yellow = DayType(
    title: "Желтый",
    emoji: "💛",
    text: "Внимание, чудеса вполне возможны, напрягайся, будь готов!"
)

let orange = DayType(
    title: "Оранжевый",
    emoji: "🧡",
    text: "Максимальный полет фантазии, состояние без дна и берегов."
)

let easier = DayType(
    title: "Легче",
    emoji: "🙂",
    text: nil
)

let harder = DayType(
    title: "Труднее",
    emoji: "🙁",
    text: nil
)

let hangOut = DayType(
    title: "Потусуйтесь",
    emoji: "🥳",
    text: nil
)

let rest = DayType(
    title: "Отдых",
    emoji: "😎",
    text: nil
)

let firstDay: [AnnualEnum: DayType] = [
    .rat: easier,
    .bull: orange,
    .tiger: green,
    .cat: hangOut,
    .dragon: easier,
    .snake: red,
    .horse: harder,
    .goat: yellow,
    .monkey: blue,
    .rooster: rest,
    .dog: harder,
    .boar: hangOut
]

let secondDay: [AnnualEnum: DayType] = [
    .rat: green,
    .bull: harder,
    .tiger: hangOut,
    .cat: easier,
    .dragon: blue,
    .snake: harder,
    .horse: yellow,
    .goat: easier,
    .monkey: orange,
    .rooster: harder,
    .dog: hangOut,
    .boar: red
]

let thirdDay: [AnnualEnum: DayType] = [
    .rat: blue,
    .bull: hangOut,
    .tiger: orange,
    .cat: rest,
    .dragon: harder,
    .snake: yellow,
    .horse: easier,
    .goat: green,
    .monkey: red,
    .rooster: hangOut,
    .dog: easier,
    .boar: rest
]

let fourthDay: [AnnualEnum: DayType] = [
    .rat: hangOut,
    .bull: easier,
    .tiger: rest,
    .cat: red,
    .dragon: yellow,
    .snake: easier,
    .horse: orange,
    .goat: harder,
    .monkey: hangOut,
    .rooster: blue,
    .dog: rest,
    .boar: green
]

let fifthDay: [AnnualEnum: DayType] = [
    .rat: easier,
    .bull: rest,
    .tiger: harder,
    .cat: yellow,
    .dragon: green,
    .snake: rest,
    .horse: harder,
    .goat: hangOut,
    .monkey: easier,
    .rooster: red,
    .dog: blue,
    .boar: orange
]

let sixthDay: [AnnualEnum: DayType] = [
    .rat: rest,
    .bull: green,
    .tiger: yellow,
    .cat: easier,
    .dragon: rest,
    .snake: blue,
    .horse: hangOut,
    .goat: red,
    .monkey: rest,
    .rooster: harder,
    .dog: orange,
    .boar: easier
]

let seventhDay: [AnnualEnum: DayType] = [
    .rat: harder,
    .bull: yellow,
    .tiger: red,
    .cat: rest,
    .dragon: harder,
    .snake: hangOut,
    .horse: easier,
    .goat: blue,
    .monkey: harder,
    .rooster: orange,
    .dog: green,
    .boar: rest
]

let eighthDay: [AnnualEnum: DayType] = [
    .rat: yellow,
    .bull: easier,
    .tiger: rest,
    .cat: harder,
    .dragon: hangOut,
    .horse: red,
    .snake: orange,
    .goat: harder,
    .monkey: green,
    .rooster: easier,
    .dog: rest,
    .boar: blue
]

let ninthDay: [AnnualEnum: DayType] = [
    .rat: orange,
    .bull: rest,
    .tiger: harder,
    .cat: blue,
    .dragon: red,
    .snake: rest,
    .horse: green,
    .goat: hangOut,
    .monkey: easier,
    .rooster: rest,
    .dog: harder,
    .boar: yellow
]


let tenthDay: [AnnualEnum: DayType] = [
    .rat: rest,
    .bull: red,
    .tiger: blue,
    .cat: orange,
    .dragon: rest,
    .snake: harder,
    .horse: hangOut,
    .goat: easier,
    .monkey: rest,
    .rooster: green,
    .dog: yellow,
    .boar: easier
]

let eleventhDay: [AnnualEnum: DayType] = [
    .rat: harder,
    .bull: blue,
    .tiger: easier,
    .cat: green,
    .dragon: orange,
    .snake: hangOut,
    .horse: easier,
    .goat: rest,
    .monkey: harder,
    .rooster: yellow,
    .dog: red,
    .boar: rest
]

let twelveDay: [AnnualEnum: DayType] = [
    .rat: red,
    .bull: easier,
    .tiger: rest,
    .cat: harder,
    .dragon: hangOut,
    .snake: green,
    .horse: blue,
    .goat: orange,
    .monkey: yellow,
    .rooster: easier,
    .dog: rest,
    .boar: harder
]

let dayTypeInfo = "Самым подробным образом структурный гороскоп разобрался с годами и месяцами, обнаружив в череде обыденных лет т.н. чудесные периоды. Период в 12 лет содержит 5 чудесных годов. Главными источниками чудес считаются кармический (знак векторного хозяина) и антикармический (знак векторного слуги) годы. Далее идут именной (свой знак), второй кармический (слуга слуги) и второй антикармический (хозяин хозяина) годы. Аналогичная ситуация с зодиакальными знаками и чудесными месяцами.\n\nОднако наша жизнь настолько ускорилась, что ждать удачного года и даже месяца не всегда возможно. Дела идут и требуют нашего постоянного присутствия. Удача требуется куда как чаще чем раз в 12 лет или даже раз в году. Что ж можно порадоваться за тех, кому помощь фортуны требуется часто – календарь удачи обнаружен и будет приведен для всех 12 знаков чуть ниже. Но для начала история создания календаря, а за одно некоторые размышления о пользе поиска научной парадигмы.\n\nНе секрет, что структурный гороскоп находится в самой тесной конкуренции с астрологией. Причем главное противоречие не в идеологии и не в терминологии, тут еще можно было бы как-то договориться, а в парадигме, то есть в исходной концептуальной схеме.\n\nАстрология, как известно, все списывает на небо, на звезды, планеты и даже астероиды. Мол, движение небесных тел есть единственный источник и мерило времени и вся наша жизнь подчинена именно этому небесному маятнику, точнее суперпозиции множества маятников: Солнца, Луны, Марса, Меркурия, Юпитера, Венеры, Сатурна (это видимо главные персонажи, ибо им нашлось место в семидневке), но также Плутона, Нептуна, а еще планет не открытых астрономами а также планет-невидимок. Что на фоне такой роскоши мог предложить структурный гороскоп? Только то, в чем есть реальная уверенность, например, так называемый Восточный, 12-летний гороскоп. Его существование, кстати, астрология совершенно не в состоянии объяснить. Все попытки притянуть к объяснению годового гороскопа цикла Юпитера попросту смешны, ибо 11, 9 лет (цикл вращения Юпитера) никогда не превратится в 12. Более того, разница будет с каждым годом нарастать. А ведь поправка в одну десятую всего лишь за один век сдвинула бы гороскоп на один год, что совершенно спутало бы все карты.\n\nИдем дальше: зодиакальный гороскоп, те самые Козероги, Водолеи, Рыбы... Его открытие и право на использование астрология монополизировала, а сами астрологи обижаются, если другие системы используют зодиакальный гороскоп без их спроса. На самом деле к астрологической доктрине зодиакальный гороскоп не имеет никакого отношения. Астрологи утверждают, что разделили небо на 12 секторов. Но с таким же успехом можно было бы делить на 12 секторов земной шар, страну, город, что угодно… Москва очень подходит для этого, например, на московской кольцевой линии метро ровно 12 станций. Прекрасный вариант для символики, ничем не хуже небесного. Но он бы увел людей от неба, что подорвало бы астрологическую парадигму.\n\nСуть же дела очень проста – год делится на 12 секторов времени, что замечательно отражено в существовании 12 месяцев года (январь, февраль, март и так далее). Единственная закавыка – это даты переходов между секторами, знаки зодиака и месяцы сдвинуты относительно друг друга. Тут астрологи вроде бы молодцы, их даты очень близки к истине. Близки, но и только… Спрашивается, в чем проблема? А проблема в том, что сами астрологи не умеют определять границы зодиакальных знаков. Какие-то сложные таблицы, а толку чуть, ведь сформулировать чем собственно Козерог должен отличаться от Водолея, а Водолей от Рыб астрологи не могут. Более того, они утверждают, что люди, родившиеся на границе двух знаков несут свойства обоих стихий. Какие уж тут границы при такой бесхарактерности. А вот структурный гороскоп, построенный на принципах жесткой дискретности делает это достаточно легко и уверенно («Зодиакальные границы», «З» № 134)\n\nТаким образом, две огромные реальности (годовой и зодиакальный гороскопы) к небу (космосу) не имеют никакого отношения. А тут новая парадигма буквально вырастает на глазах. Не нужен космос для того чтобы умножить на 12 (годовой гороскоп) и разделить на 12 (зодиакальный гороскоп) одну единственную астрономическую достоверность – год (время вращения Земли вокруг Солнца). Вот вам и парадигма: человек квантует время кратно двенадцати. Более того, возникает основание заявить, что человек – это единственное существо, которое может взаимодействовать со временем, умеет квантовать его. Так новая парадигма отделяет человека от природы, доказывая триединое строение мироздания: Природа – Человек – Бог.\n\nОсновой для квантования может стать любая земная единица времени, а таковых всего две: год и сутки (время вращения Земли вокруг своей оси). Интересно, кстати, что будет с человеком и его гороскопами при полете на Луну или на Марс? Так называемые внутренние хронометры могут очень серьезно забарахлить. Что уж говорить о людях рожденных, например, на Марсе. Что они будут квантовать? Вот проблема! Ну а пока для новой парадигмы главной стала задача квантования суток. Впервые внятно и четко было предсказано это явление в «Сломанных часах» («З» № 55). Однако одно дело сделать красивое предсказание, а другое дело взяться за создание совершенно нового, не виданного доселе гороскопа. Тут, как говорится, для новой парадигмы наступил час истины.\n\nСейчас, задним числом, легко говорить о том, что существовал некий план открытия. Если план и был, то в каких-то смутных контурах. Теперь он ясен и кристально чист (задним числом). Во-первых, надо было досконально изучить внутреннее строение суток (квантование внутрь дня) и расставить знаки по своим местам, что и было сделано («Час волка» «З» № 135). Получив порядок следования знаков, а он оказался совсем не тот, что у зодиакального и годового гороскопов (колесо закрутилось в обратную сторону), а также наименование знака номер один (им оказался Петух) можно было приступать ко второму действию, а именно к поиску в череде дней первого дня 12-дневного цикла. Был проведен анализ самых знаменитых дат мировой истории и на удивление легко (а я-то думал, что именно это будет самым трудным) этот день был найден. Подробно об этом в «Дне Икс» («З» № 143).\n\nНу и, наконец, самый простой и самый выгодный – третий шаг – это собственно написание нового (12-дневного гороскопа). Отсчет начнем с ноября 2005 года, причем, что удивительно, наверное, это добрый знак, 1 ноября – это день Петуха, 2 ноября – день Обезьяны, 3 ноября – день Козы, 4 ноября - день Лошади, 5 ноября – день Змеи, 6 ноября - день Дракона, 7 ноября - день Кота, 8 ноября – день Тигра, 9 ноября - день Быка, 10 ноября - день Крысы, 11 ноября – день Кабана, 12 ноября – день Собаки, 13 ноября – вновь день Петуха и так далее. Пока не началось массовое производство новых календарей, придется дальнейшие расчеты производить самим, вручную или с помощью компьютерных программ, которые рассчитают все на много лет вперед.\n\nЧто с этим делать дальше? Шутка ли сказать – ведь найден четвертый гороскоп. У него должно быть множество применений. Но пока, как и было заявлено в начале, займемся поиском дней удачи и дней потенциальных неудач, дней белых и дней черных, того, что в классической теории называется антикармическими и кармическими днями.\n\nИдеология в принципе та же, что и разрабатывалась для кармических и антикармических лет. То есть в кармический день идет некая расплата за старые ошибки, высвечиваются слабые места, окружающие норовят лягнуть побольнее, человек становится беззащитен и все это чувствуют. В антикармический день, напротив, все очарованы, появляется легкость и удача, человек проходит сквозь преграды как нож сквозь масло. Таким образом, на черный (антикармический) день стоит запланировать неприятные, но нужные дела, отдача долгов, уплата по счетам, поход к стоматологу, и так далее… Ну а на белый день надо планировать выбивание долгов, поход к начальству с каким-то блестящим проектом, ну или просто на свидание пригласить кого-нибудь. Одним словом любое дело, требующее очарования и вдохновения."