//
//  AnnualSignInstances.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 13.04.2023.
//

import Foundation

let annualSigns: [SignStruct] = [ratSign, bullSign, tigerSign, catSign, dragonSign, snakeSign, horseSign, goatSign, monkeySign, roosterSign, dogSign, pigSign]

let ratSign = SignStruct(
    annualSign: .rat, site: "https://www.xsp.ru/sh/znaki/znak.php?id=1",
    ideologicalType: [.male: .mystical, .female: .realistic],
    socialType: .opened,
    psychologicalType: .maturity,
    temperament: .dramatic,
    fateType: .fatalist,
    ageType: .youth,
    vectorHost: .monkey,
    vectorServant: .horse,
    romanticMarriage: [.dog, .tiger],
    patriarchalMarriage: [.rat, .dragon],
    equalMarriage: [.cat,.goat,.pig],
    spiritualMarriage: [.bull, .snake, .rooster],
    clones: [.rat, .tiger, .dog],
    companions: [.dragon],
    subordinates: [.cat, .goat, .pig],
    advisers: [.bull, .snake, .rooster],
    virtualSigns: [
        .capricorn: aristocratSign,
        .aquarius: knightSign,
        .pisces: jesterSign,
        .aries: kingSign,
        .taurus: jesterSign,
        .gemini: knightSign,
        .cancer: aristocratSign,
        .leo: professorSign,
        .virgo: leaderSign,
        .libra: vectorSign,
        .scorpio: leaderSign,
        .sagittarius: vectorSign,
    ],
    businessStruct: [
        .rat: .clone,
        .bull: .adviser,
        .tiger: .clone,
        .cat: .subordinate,
        .dragon: .companion,
        .snake: .adviser,
        .horse: .vectorServant,
        .goat: .subordinate,
        .monkey: .vectorHost,
        .rooster: .adviser,
        .dog: .clone,
        .pig: .subordinate
    ], blocks: [
        "": "Может быть вы или ваш ребенок родились именно в год Крысы, сверьтесь со списком: годы Крысы -- 1912, 1924, 1936, 1948, 1960, 1972, 1984, 1996. Что касается разночтений по поводу того, в какие числа января начинается год Крысы, то, будьте уверены, она из своего года не отдает ни дня. Многократные проверки показали, что год Крысы начинается 1 января, может быть, даже 31 декабря. Для недоверчивых сообщаю, что самым тщательным образом исследовались биографии и творческое наследие Джека Лондона (12.1.1876), Николая Рубцова (3.1.1936), Сергея Параджанова (9.1.1924) и ряда других известных лиц, родившихся в первых числах января 'крысиных' лет. Все они, по всем своим свойствам, целиком в рамках знака Крысы и к царству Кабана никакого отношения не имеют.\n\nИтак, Крыса. Надо ли, описывая этот знак, думать именно о крысах, шустрых сереньких зверьках. Может быть, кому-то совсем не хочется сравнивать себя с ними. И все же в этом зоологическом аналоге ясно видны многие черты этого знака. Крысы плавают на кораблях, ездят на поездах, живут в лачугах и дворцах, городах и деревнях, в поле и в лесу -- они вездесущи и космополитичны, как и полагается открытому знаку. Именно крысы терпеть не могут непроходимые стены и вообще любые ограничения свободы. С крысой связаны наши представления о всеядности и безжалостности. Та же крыса известна своим пристрастием к воде.\n\nА крысиные лапки? Они удивительно ловки. Именно это свидетельствует об экспериментаторских и любовных способностях животных.\n\nВот с помощью такого сравнения мы и обнаружили основные качества людей родившихся в годы Крысы: открытость, безжалостность, экспериментальный и любовный дар. Что касается внешнего сходства, о котором люди думают прежде всего, то увидеть можно и его. Обычно выделяют два противоположных типа конституции: длинный и ломкий (а-ля Сергей Филиппов) и бобровый (бобер -- тоже грызун) укороченный (а-ля Гавриил Попов), хотя автору приходилось видеть Крыс вне всякого внешнего типажа.\n\n",
        "МИСТИЧЕСКОЕ МЫШЛЕНИЕ": "Людям знака Крысы присуще так называемое мистическое мышление, которое характеризуется двумя 'не': мистики не верят в абстрактные схемы, жесткую логику, справедливо полагая, что догматизм в реальной жизни скорее помеха, чем помощник, они не признают и застывший опыт, житейскую мудрость. Эти два 'не' делают из Крыс замечательных экспериментаторов, ибо им для любых умозаключений все надо пощупать, понюхать, перепроверить. Вот почему Крысы, не будучи логиками и реалистами, чрезвычайно распространены в науке.\n\nСледствий мистического мышления множество. Его обладатель с одной стороны мелочный и аккуратист (экспериментатор в науке), с другой стороны человек не от мира сего, почти лунатик. В любом случае понятие о норме для Крыс чрезвычайно расширено. Раскованность и свобода 'крысиной' мысли почти не знает границ. Но проблема в том, что мистические явления образуют круг тех самых вечных вопросов, которые, как известно, не решаемы. Что, впрочем, не отменяет подчинения этих явлений своим законам. В природе мистическим законам подчиняются стихии огня и воды, все что связано с цепными реакциями, вихревым движением. В мире людей это и сновидения, и тесно связанные с миром грез направления в искусстве -- сюрреализм, театр абсурда. Однако нет более мистического явления, чем любовь. Она не знает законов логики, и формула любви, к которой стремился Калиостро, не вычислима. Но ведь и житейский опыт в любви бесполезен, более того, он сплошь и рядом мешает любви, заглушает чистый 'голос сердца'. Так вот, Крысы, отвергающие, как было сказано, житейскую мудрость и опыт, более других смогли приблизиться к тайнам любви. Благодаря тем самым двум 'не'. Первейший из них -- это Шекспир, именно он сумел хоть что-то прояснить в этом непостижимом явлении, его драматургия -- это и есть 'энциклопедия любви'. Второй, наверное, -- Лев Толстой, один из величайших проповедников любви. Я мог бы привести длиннейший список Крыс, большая часть которых оказалась бы драматургами. Именно драматургия призвана ставить вечные вопросы и искать на них ответы, именно драматургия призвана выводить нас за пределы времени. Лидерство Крыс в драматургии подавляющее. Причем лидерство Крысы практически интернационально. В самом деле, вечные проблемы едины для всех. Большие проблемы у мистиков с причинно-следственной связью. Как люди вне времени они с трудом различают последовательность в цепи событий. Обо всем этом важно знать всем, кто имеет дело с Крысами. Мышление Крыс склоняется к абсурду, и для них это норма. С мистическим мышлением связана уникальная емкость крысиного мозга. Люди этого знака в состоянии удерживать в своем сознании огромный массив несистематизированной информации. Крыса обладает способностью ставить рядом несопоставимое и сводить воедино несоединимое. В жизни использовать эту уникальную способность почти невозможно, но помнить о ней надо.\n\nМистическое мышление порождает так называемую романтическую волю, которая имеет вид некой идеи-фикс, мобилизуя все силы организма на достижение цели, не имеющей никакого рационального объяснения. Как пример мы еще рассмотрим крысиное стремление к воде, хотя число подобных 'маний' у них может быть довольно большим. Внимание! Все вышесказанное относится к мужчинам -- Крысам. У женщин этого знака дела обстоят несколько иначе, их тип мышления -- другой!\n\n",
        "ЖЕНСКИЙ РЕАЛИЗМ": "Если мужчина-Крыса более явление природы -- иногда достаточно мирной, иногда разбушевавшейся, то женщина-Крыса природное буйство скорее демонстрирует, ловко пользуется маской своего знака, скрывая за нею вполне трезвый расчет и здравое мышление. Женщины-Крысы -- реалистки, они молятся тому самому богу житейской мудрости, к которому так презрительно относятся мужчины-Крысы.\n\nРеализм -- это знание человеческой психологии, острый наблюдательный взгляд, умелое участие в интригах, сбор и распространение информации (и слухов тоже), любовь к деньгам и шмоткам, словом, все то, что обычно приписывается женскому роду в целом. С другой стороны, их реализм - это безупречное чувство прекрасного, изысканный вкус, стилистическое совершенство.\n\nКак вершина знакового творчества -- женская проза, все каноны которой фактически созданы Крысами. Достаточно назвать три имени, хотя список мог быть и длиннее. Жорж Санд (1804--1876), Маргарет Митчелл (1900--1949), автор 'Унесенных ветром' и, самая знаменитая из сестер Бронте, -- Шарлотта (1816--1855). О них ведь так и пишут критики -- создатели реалистической женской прозы.\n\nА по всему поэтому девочек, родившихся в год Крысы, первым делом надо проверять на эстетическое чутье, приобщать к искусству, литературе, выявить их способности к языкам. Как правило, для них удачны карьеры переводчиков, редакторов, искусствоведов, модельеров. Лидирует женщина-Крыса в исполнительской музыке, ждем лидерства этого знака и в женских шахматах.\n\nРеалистический тип мышления влияет и на общую жизненную стратегию. В ней значительную роль должны играть мужчины. Крыса любит быть красивой, любит нравиться, любит быть в центре внимания. Однако у этого знака нет силы воли, а потому эти женщины не могут рассчитывать только на самих себя, они с удовольствием опираются на чье-то твердое стратегическое плечо. Тяга к деньгам, красивым нарядам, неизменное беспокойство о своем здоровье -- все это также требует присутствия того, кто будет заботиться и оберегать ее покой. Именно покой, ибо при всех своих резкостях и буйствах Крыса прежде всего жаждет покоя, равновесия, благополучия, благоустроенности. А уж на фоне материального и прочего благополучия она с удовольствием изобразит необузданность, мятежность и так далее.\n\nЖенщины-Крысы красивы. Да, я знаю, некрасивых женщин не бывает, все знаки красивы по-своему. Но тут красота, которая смягчает черты лица, это легкая, спокойная походка, прямая осанка. Именно покой, внутренняя гармония и равновесие, созерцательность, самолюбование обеспечивает Крысе ее прославленную красоту. Конечно, излишний покой может сделать Крысу слишком пресной, но, как правило, ей это не грозит, ибо после длинных периодов покоя всегда следуют мощные эмоциональные выплески, -- вечные спутники реалистов.\n\nВ эмоциональных взрывах Крыса настоящий профессионал, можно сказать, виртуоз. Достигается виртуозность долгими тренировками. За свои вспышки Крысе не бывает стыдно, ибо они всегда точно бьют в цель, всегда преследуют результат и всегда его достигают. В этом смысле Крыса -- идеальный женский знак, все доблести, приписываемые женщине молвой, здесь в самом деле имеют место быть.\n\n",
        "ХОЛЕРИЧЕСКИЙ ТЕМПЕРАМЕНТ": "Самый буйный из четырех темпераментов -- холерический -- в нашем сознании связывается с максимумом энергии. На деле у холериков (Крыса, Змея и Коза) -- минимум энергии, а ведут они себя сверхактивно, дабы взбодрить организм, как-то оживить его. Немудрено, что за вспышками активности вполне могут последовать глубочайшие депрессии. Надежного источника энергии, который постоянно бы подпитывал эти знаки, не существует (разве что одолжить у чересчур активных людей). А потому спасение -- в чередовании сверхактивности и длительных периодов глубокого покоя.\n\nОбо всем этом нужно знать и воспринимать вспышки активности, а также энергетические провалы, как норму Крысы. Структурный гороскоп данный тип темперамента именует драматическим. Означает это некую способность драматизировать обыденные, на первый взгляд, ситуации, превращая их либо в комедии, либо в трагедии. (Может быть, самый гениальный представитель знака -- Шекспир своим творчеством замечательно иллюстрирует энергетический разброс, -- от комедий с беспредельным весельем и гульбой, до трагедий, в которых темно как в черных дырах, нет ни лучика, ни звездочки: вот так они и живут...)\n\nВместе с природными оптимистами драматические знаки образуют шестерку социально активных знаков, людей близко к сердцу принимающих человеческие проблемы. Сочетание неподдельного интереса к людям со способностью погружаться в глубины собственного сознания делает знак одаренным во всем, что связано с пониманием человека, -- это психология, медицина, беллетристика и так далее.\n\n",
        "ФАТАЛИЗМ": "Семья и школа призывает ребенка к борьбе с трудностями, самовоспитанию, самосовершенствованию, и это во многом оправдано; если сам человек не захочет стать человеком, то никто его не заставит. Тем не менее мы вынуждены согласиться с тем, что на многих людях с детства лежит печать обреченности. Одним судьба быть гением, другим судьба быть бездарью, одним победу в бою одержать, другим голову сложить.\n\nСамый понятный пример -- это судьба Моцарта, который родился в год Крысы и, кажется, сразу же был гением. Знаменитый конфликт с Сальери, даже если он придуман, очень показателен. Сальери всю жизнь выстраивал себя, вел себя со ступени на ступень, Моцарт же получил все сразу, в прямое нарушение каких бы то ни было причинно-следственных связей. В этом смысле биографии представителей фатальных знаков (Тигр, Собака, Крыса) всегда лишены назидательности и нравоучительства. Из них нельзя извлечь уроков. Совершенно непонятно, откуда что берется и куда что девается. Менее всего фатальные биографии можно считать карьерой. Более всего подходит слово -- судьба.\n\nИз всего сказанного следует, что ребенка-Крысу нужно не столько воспитывать, сколько угадать. Угадать судьбу и помочь ей осуществиться в лучшем виде.\n\nФатализм можно посчитать удобным оправданием для бездействия и пассивности, мол, мое меня не минует. Однако обвинить в пассивности можно лишь тех, кто не нашел свою судьбу. Если же судьба, то бишь направление, путь, найдена, то фаталист демонстрирует фантастическое упорство и несгибаемое трудолюбие, какое и не снится тому, кто каждый час решает, как ему жить. Парадоксально, фатальным является не только мужской знак Крысы, но и женский. Как совместить жесткий реализм и полнейшее трезвомыслие с каким-то там загадочным фатализмом? Что ж, и реалисты любят играть в рулетку. В самом деле -- все самое главное в жизни женщины -- муж, дети, красота, вечная молодость, ведь все это судьба, будь ты хоть трижды трезвомыслящий.\n\nНаверное, повод поразмышлять о своей судьбе тем, кто связывает жизнь с фатальным знаком. Знайте, что фаталиста не удастся переделать, перекроить на свой лад. Каким получили, с таким живите.\n\n",
        "ВОЗМУЖАНИЕ": "Сверхчуствительная энергетика Крысы находится в очевидном противоречии с психологической малочувствительностью. Так, в юности глубина и тонкость переживаний скрываются за грубыми манерами, молодежным жаргоном, шокирующими идеями. Великие скабрезники, любители эпатажа среди Крыс попадались достаточно часто. Вспомним Франсуа Вийона, наших Баркова, Полежаева...\n\nВ этом знаке сходятся самые противоположные качества и буквально раздирают его на части, требуя от человека противоположных вещей. Каждый отдельный человек может владеть тем или иным качеством в определенной пропорции. Один возьмет себе побольше грубости и поменьше глубоких переживаний, другой, напротив, уйдет в переживания, всю жесткость требований обратя на себя, а не на других. В этом состоит главный фокус структурного гороскопа; он не требует использования человеком всех структурных составляющих знака. Родители, видимо, тоже могут поучаствовать в процессе комплектования качеств своего чада.\n\n",
        "ОТКРЫТОСТЬ": "Крысы-животные не признают границ, проникают везде и всюду, не любят замыкаться в ограниченном пространстве. Люди, родившиеся в годы Крысы, безусловно обладают широтой натуры, тяготеют к простоте в обращении, не являются поклонниками особенных церемоний. Открытость в музыке, сочиняемой Крысами, открытость в их фильмах, в их книгах.\n\nВажнейшая особенность открытых знаков -- их стремление нравиться всем. Закрытый знак спокойно живет в атмосфере неприязни, ортодоксальный знак очень ценит расположение 'своих', но равнодушен к мнению 'чужих', но только открытый знак буквально заболевает от того, что его кто-то, пусть и чужой, не любит. Последствия могут быть самые печальные, вплоть до психических отклонений, мизантропии и так далее. А потому -- любите Крыс, тем более, что их обычно есть за что любить.\n\nСамое универсальное проявление открытости знака -- это создание музыки, которая нравится всем подряд, независимо от образования, социального положения, возраста и даже наличия музыкального слуха. Моцарт и Россини, Чайковский и Глинка, Исаак Дунаевский и Ллойд Вебер -- вот пример. Кому не пришлось по душе хотя бы что-то из их музыки?\n\n",
        "СТРАННОСТИ": "Их у Крыс много, и наиболее симпатичная странность -- страсть к воде. Масштаб страсти тем больше, чем больше (физически) человек. Так, Петр I, стремясь к воде, переместил столицу сухопутного государства в болота и создал великий флот. Николай Рубцов, стремясь к воде, всего лишь бросил школу и пошел на флот. Юрий Лужков тоже любит воду, но держит себя в руках, всего-навсего корт Севастополь отстаивает и подводные лодки финансирует.\n\nТак что испытайте ребенка-Крысу на любовь к воде. Как знать, может быть, судьба ему стать мореходом, океанографом, рыбаком, а может быть, тем, кто по мысли доктора Сальватора должен начать заселять мировой океан.\n\n"
    ]
)

let bullSign = SignStruct(
    annualSign: .bull, site: "https://www.xsp.ru/sh/znaki/znak.php?id=2",
    ideologicalType: [.male: .logical, .female: .strongWilled],
    socialType: .orthodox,
    psychologicalType: .maturity,
    temperament: .sanguine,
    fateType: .lucky,
    ageType: .teenager,
    vectorHost: .dog,
    vectorServant: .tiger,
    romanticMarriage: [.cat, .goat, .pig],
    patriarchalMarriage: [.bull, .snake, .rooster],
    equalMarriage: [.horse],
    spiritualMarriage: [.rat, .monkey, .dragon],
    clones: [.bull, .cat, .snake],
    companions: [.goat, .rooster, .pig],
    subordinates: [.rat, .dragon, .monkey],
    advisers: [.horse],
    virtualSigns: [
        .capricorn: professorSign,
        .aquarius: vectorSign,
        .pisces: knightSign,
        .aries: jesterSign,
        .taurus: kingSign,
        .gemini: vectorSign,
        .cancer: knightSign,
        .leo: aristocratSign,
        .virgo: professorSign,
        .libra: leaderSign,
        .scorpio: aristocratSign,
        .sagittarius: leaderSign
    ],
    businessStruct: [
        .rat: .subordinate,
        .bull: .clone,
        .tiger: .vectorServant,
        .cat: .clone,
        .dragon: .subordinate,
        .snake: .clone,
        .horse: .adviser,
        .goat: .companion,
        .monkey: .subordinate,
        .rooster: .companion,
        .dog: .vectorHost,
        .pig: .companion
    ], blocks: [
        
    ]
)

let tigerSign = SignStruct(
    annualSign: .tiger, site: "https://www.xsp.ru/sh/znaki/znak.php?id=3",
    ideologicalType: [.male: .strongWilled, .female: .logical],
    socialType: .closed,
    psychologicalType: .dreamer,
    temperament: .phlegmatic,
    fateType: .fatalist,
    ageType: .outgoing,
    vectorHost: .bull,
    vectorServant: .goat,
    romanticMarriage: [.rat, .monkey, .dragon],
    patriarchalMarriage: [.tiger, .horse, .dog],
    equalMarriage: [.snake, .rooster],
    spiritualMarriage: [.cat, .pig],
    clones: [.rat, .tiger, .dog],
    companions: [.dragon, .horse, .monkey],
    subordinates: [.snake, .rooster],
    advisers: [.cat, .pig],
    virtualSigns: [
        .capricorn: leaderSign,
        .aquarius: professorSign,
        .pisces: aristocratSign,
        .aries: knightSign,
        .taurus: vectorSign,
        .gemini: kingSign,
        .cancer: jesterSign,
        .leo: knightSign,
        .virgo: aristocratSign,
        .libra: professorSign,
        .scorpio: vectorSign,
        .sagittarius: aristocratSign
    ],
    businessStruct: [
        .rat: .clone,
        .bull: .vectorHost,
        .tiger: .clone,
        .cat: .adviser,
        .dragon: .companion,
        .snake: .subordinate,
        .horse: .companion,
        .goat: .vectorServant,
        .monkey: .companion,
        .rooster: .subordinate,
        .dog: .clone,
        .pig: .adviser
    ], blocks: []
)

let catSign = SignStruct(
    annualSign: .cat, site: "https://www.xsp.ru/sh/znaki/znak.php?id=4",
    ideologicalType: [.male: .realistic, .female: .mystical],
    socialType: .opened,
    psychologicalType: .dreamer,
    temperament: .melancholic,
    fateType: .lucky,
    ageType: .triumphant,
    vectorHost: .dragon,
    vectorServant: .rooster,
    romanticMarriage: [.bull, .snake],
    patriarchalMarriage: [.cat, .goat, .bull],
    equalMarriage: [.rat, .monkey],
    spiritualMarriage: [.tiger, .horse, .dog],
    clones: [.bull, .cat, .snake],
    companions: [.goat, .pig],
    subordinates: [.tiger, .horse, .dog],
    advisers: [.rat, .monkey],
    virtualSigns: [
        .capricorn: vectorSign,
        .aquarius: leaderSign,
        .pisces: professorSign,
        .aries: aristocratSign,
        .taurus: knightSign,
        .gemini: jesterSign,
        .cancer: kingSign,
        .leo: vectorSign,
        .virgo: knightSign,
        .libra: aristocratSign,
        .scorpio: professorSign,
        .sagittarius: leaderSign
    ],
    businessStruct: [
        .rat: .adviser,
        .bull: .clone,
        .tiger: .subordinate,
        .cat: .clone,
        .dragon: .vectorHost,
        .snake: .clone,
        .horse: .subordinate,
        .goat: .companion,
        .monkey: .adviser,
        .rooster: .vectorServant,
        .dog: .subordinate,
        .pig: .companion
    ], blocks: []
)

let dragonSign = SignStruct(
    annualSign: .dragon, site: "https://www.xsp.ru/sh/znaki/znak.php?id=5",
    ideologicalType: [.male: .mystical, .female: .realistic],
    socialType: .orthodox,
    psychologicalType: .dreamer,
    temperament: .phlegmatic,
    fateType: .doItYourself,
    ageType: .teacher,
    vectorHost: .bull,
    vectorServant: .cat,
    romanticMarriage: [.tiger, .horse, .dog],
    patriarchalMarriage: [.rat, .monkey, .dragon],
    equalMarriage: [.goat],
    spiritualMarriage: [.bull, .snake, .rooster],
    clones: [.dragon, .horse, .monkey],
    companions: [.rat, .tiger, .dog],
    subordinates: [.goat],
    advisers: [.bull, .snake, .rooster],
    virtualSigns: [
        .capricorn: leaderSign,
        .aquarius: aristocratSign,
        .pisces: vectorSign,
        .aries: professorSign,
        .taurus: aristocratSign,
        .gemini: knightSign,
        .cancer: vectorSign,
        .leo: kingSign,
        .virgo: jesterSign,
        .libra: knightSign,
        .scorpio: aristocratSign,
        .sagittarius: professorSign
    ],
    businessStruct: [
        .rat: .companion,
        .bull: .adviser,
        .tiger: .companion,
        .cat: .vectorServant,
        .dragon: .clone,
        .snake: .adviser,
        .horse: .clone,
        .goat: .subordinate,
        .monkey: .clone,
        .rooster: .adviser,
        .dog: .companion,
        .pig: .vectorHost
    ], blocks: []
)

let snakeSign = SignStruct(
    annualSign: .snake, site: "https://www.xsp.ru/sh/znaki/znak.php?id=6",
    ideologicalType: [.male: .logical, .female: .strongWilled],
    socialType: .closed,
    psychologicalType: .sensitive,
    temperament: .dramatic,
    fateType: .lucky,
    ageType: .success,
    vectorHost: .goat,
    vectorServant: .monkey,
    romanticMarriage: [.cat, .pig],
    patriarchalMarriage: [.bull, .snake, .rooster],
    equalMarriage: [.tiger, .horse, .dog],
    spiritualMarriage: [.rat, .dragon],
    clones: [.bull, .cat, .snake],
    companions: [.rooster, .pig],
    subordinates: [.rat, .dragon],
    advisers: [.tiger, .horse, .dog],
    virtualSigns: [
        .capricorn: professorSign,
        .aquarius: leaderSign,
        .pisces: aristocratSign,
        .aries: leaderSign,
        .taurus: professorSign,
        .gemini: aristocratSign,
        .cancer: knightSign,
        .leo: jesterSign,
        .virgo: kingSign,
        .libra: jesterSign,
        .scorpio: vectorSign,
        .sagittarius: vectorSign
    ],
    businessStruct: [
        .rat: .subordinate,
        .bull: .clone,
        .tiger: .adviser,
        .cat: .clone,
        .dragon: .subordinate,
        .snake: .clone,
        .horse: .adviser,
        .goat: .vectorHost,
        .monkey: .vectorServant,
        .rooster: .companion,
        .dog: .adviser,
        .pig: .companion
    ], blocks: []
)

let horseSign = SignStruct(
    annualSign: .horse, site: "https://www.xsp.ru/sh/znaki/znak.php?id=7",
    ideologicalType: [.male: .strongWilled, .female: .logical],
    socialType: .opened,
    psychologicalType: .sensitive,
    temperament: .sanguine,
    fateType: .doItYourself,
    ageType: .juniorSchoolStudent,
    vectorHost: .rat,
    vectorServant: .pig,
    romanticMarriage: [.dragon, .monkey],
    patriarchalMarriage: [.horse, .dog, .tiger],
    equalMarriage: [.rooster, .snake, .bull],
    spiritualMarriage: [.cat, .goat],
    clones: [.dragon, .horse, .monkey],
    companions: [.tiger, .dog],
    subordinates: [.bull, .snake, .rooster],
    advisers: [.cat, .goat],
    virtualSigns: [
        .capricorn: aristocratSign,
        .aquarius: professorSign,
        .pisces: vectorSign,
        .aries: vectorSign,
        .taurus: leaderSign,
        .gemini: professorSign,
        .cancer: aristocratSign,
        .leo: knightSign,
        .virgo: jesterSign,
        .libra: kingSign,
        .scorpio: jesterSign,
        .sagittarius: knightSign
    ],
    businessStruct: [
        .rat: .vectorHost,
        .bull: .subordinate,
        .tiger: .companion,
        .cat: .adviser,
        .dragon: .clone,
        .snake: .subordinate,
        .horse: .clone,
        .goat: .adviser,
        .monkey: .clone,
        .rooster: .subordinate,
        .dog: .companion,
        .pig: .vectorServant
    ], blocks: []
)

let goatSign = SignStruct(
    annualSign: .goat, site: "https://www.xsp.ru/sh/znaki/znak.php?id=8",
    ideologicalType: [.male: .realistic, .female: .mystical],
    socialType: .orthodox,
    psychologicalType: .sensitive,
    temperament: .dramatic,
    fateType: .pioneer,
    ageType: .preschooler,
    vectorHost: .tiger,
    vectorServant: .snake,
    romanticMarriage: [.bull, .rooster],
    patriarchalMarriage: [.cat, .goat, .pig],
    equalMarriage: [.rat, .monkey, .dragon],
    spiritualMarriage: [.horse, .dog],
    clones: [.goat, .rooster, .pig],
    companions: [.bull, .cat],
    subordinates: [.horse, .dog],
    advisers: [.rat, .dragon, .monkey],
    virtualSigns: [
        .capricorn: knightSign,
        .aquarius: aristocratSign,
        .pisces: professorSign,
        .aries: leaderSign,
        .taurus: aristocratSign,
        .gemini: vectorSign,
        .cancer: professorSign,
        .leo: aristocratSign,
        .virgo: vectorSign,
        .libra: jesterSign,
        .scorpio: kingSign,
        .sagittarius: jesterSign
    ],
    businessStruct: [
        .rat: .adviser,
        .bull: .companion,
        .tiger: .vectorHost,
        .cat: .companion,
        .dragon: .adviser,
        .snake: .vectorServant,
        .horse: .subordinate,
        .goat: .clone,
        .monkey: .adviser,
        .rooster: .clone,
        .dog: .subordinate,
        .pig: .clone
    ], blocks: []
)

let monkeySign = SignStruct(
    annualSign: .monkey, site: "https://www.xsp.ru/sh/znaki/znak.php?id=9",
    ideologicalType: [.male: .mystical, .female: .realistic],
    socialType: .closed,
    psychologicalType: .grounded,
    temperament: .melancholic,
    fateType: .doItYourself,
    ageType: .baby,
    vectorHost: .snake,
    vectorServant: .rat,
    romanticMarriage: [.tiger, .horse, .dog],
    patriarchalMarriage: [.monkey, .dragon],
    equalMarriage: [.cat, .goat, .pig],
    spiritualMarriage: [.pig, .rooster],
    clones: [.dragon, .horse, .monkey],
    companions: [.tiger, .dog],
    subordinates: [.cat, .goat, .pig],
    advisers: [.bull, .rooster],
    virtualSigns: [
        .capricorn: jesterSign,
        .aquarius: knightSign,
        .pisces: aristocratSign,
        .aries: vectorSign,
        .taurus: leaderSign,
        .gemini: aristocratSign,
        .cancer: leaderSign,
        .leo: professorSign,
        .virgo: vectorSign,
        .libra: knightSign,
        .scorpio: jesterSign,
        .sagittarius: kingSign
    ],
    businessStruct: [
        .rat: .vectorServant,
        .bull: .adviser,
        .tiger: .companion,
        .cat: .subordinate,
        .dragon: .clone,
        .snake: .vectorHost,
        .horse: .clone,
        .goat: .subordinate,
        .monkey: .clone,
        .rooster: .adviser,
        .dog: .companion,
        .pig: .subordinate
    ], blocks: []
)

let roosterSign = SignStruct(
    annualSign: .rooster, site: "https://www.xsp.ru/sh/znaki/znak.php?id=10",
    ideologicalType: [.male: .logical, .female: .strongWilled],
    socialType: .opened,
    psychologicalType: .grounded,
    temperament: .phlegmatic,
    fateType: .pioneer,
    ageType: .newborn,
    vectorHost: .cat,
    vectorServant: .dog,
    romanticMarriage: [.goat, .pig],
    patriarchalMarriage: [.rooster, .snake, .bull],
    equalMarriage: [.tiger, .horse],
    spiritualMarriage: [.rat, .monkey, .dragon],
    clones: [.goat, .rooster, .pig],
    companions: [.bull, .snake],
    subordinates: [.rat, .dragon, .monkey],
    advisers: [.tiger, .horse],
    virtualSigns: [
        .capricorn: kingSign,
        .aquarius: vectorSign,
        .pisces: knightSign,
        .aries: aristocratSign,
        .taurus: professorSign,
        .gemini: leaderSign,
        .cancer: vectorSign,
        .leo: leaderSign,
        .virgo: professorSign,
        .libra: aristocratSign,
        .scorpio: knightSign,
        .sagittarius: jesterSign
    ],
    businessStruct: [
        .rat: .subordinate,
        .bull: .companion,
        .tiger: .adviser,
        .cat: .vectorHost,
        .dragon: .subordinate,
        .snake: .companion,
        .horse: .adviser,
        .goat: .clone,
        .monkey: .subordinate,
        .rooster: .clone,
        .dog: .vectorServant,
        .pig: .clone
    ], blocks: []
)

let dogSign = SignStruct(
    annualSign: .dog, site: "https://www.xsp.ru/sh/znaki/znak.php?id=11",
    ideologicalType: [.male: .strongWilled, .female: .logical],
    socialType: .orthodox,
    psychologicalType: .grounded,
    temperament: .melancholic,
    fateType: .fatalist,
    ageType: .trailblazer,
    vectorHost: .rooster,
    vectorServant: .bull,
    romanticMarriage: [.rat, .monkey, .dragon],
    patriarchalMarriage: [.tiger, .horse, .dog],
    equalMarriage: [.snake],
    spiritualMarriage: [.cat, .goat, .pig],
    clones: [.rat, .tiger, .dog],
    companions: [.dragon, .horse, .monkey],
    subordinates: [.snake],
    advisers: [.cat, .goat, .pig],
    virtualSigns: [
        .capricorn: vectorSign,
        .aquarius: kingSign,
        .pisces: jesterSign,
        .aries: knightSign,
        .taurus: vectorSign,
        .gemini: professorSign,
        .cancer: leaderSign,
        .leo: aristocratSign,
        .virgo: leaderSign,
        .libra: professorSign,
        .scorpio: aristocratSign,
        .sagittarius: knightSign
    ],
    businessStruct: [
        .rat: .clone,
        .bull: .vectorServant,
        .tiger: .clone,
        .cat: .adviser,
        .dragon: .companion,
        .snake: .subordinate,
        .horse: .companion,
        .goat: .adviser,
        .monkey: .companion,
        .rooster: .vectorHost,
        .dog: .clone,
        .pig: .adviser
    ], blocks: []
)

let pigSign = SignStruct(
    annualSign: .pig, site: "https://www.xsp.ru/sh/znaki/znak.php?id=12",
    ideologicalType: [.male: .realistic, .female: .mystical],
    socialType: .closed,
    psychologicalType: .maturity,
    temperament: .sanguine,
    fateType: .pioneer,
    ageType: .intellectual,
    vectorHost: .horse,
    vectorServant: .dragon,
    romanticMarriage: [.bull, .snake, .rooster],
    patriarchalMarriage: [.cat, .goat],
    equalMarriage: [.rat, .monkey],
    spiritualMarriage: [.tiger, .dog],
    clones: [.goat, .rooster, .pig],
    companions: [.bull, .cat, .snake],
    subordinates: [.tiger, .dog],
    advisers: [.rat, .monkey],
    virtualSigns: [
        .capricorn: knightSign,
        .aquarius: jesterSign,
        .pisces: kingSign,
        .aries: jesterSign,
        .taurus: knightSign,
        .gemini: aristocratSign,
        .cancer: professorSign,
        .leo: vectorSign,
        .virgo: aristocratSign,
        .libra: vectorSign,
        .scorpio: professorSign,
        .sagittarius: aristocratSign
    ],
    businessStruct: [
        .rat: .adviser,
        .bull: .companion,
        .tiger: .subordinate,
        .cat: .companion,
        .dragon: .vectorServant,
        .snake: .companion,
        .horse: .vectorHost,
        .goat: .clone,
        .monkey: .adviser,
        .rooster: .clone,
        .dog: .subordinate,
        .pig: .clone
    ], blocks: []
)
