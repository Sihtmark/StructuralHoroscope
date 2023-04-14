//
//  KnightView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 12.04.2023.
//

import SwiftUI

struct KnightView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                paragraph1
                paragraph2
                paragraph3
                paragraph4
                paragraph5
                Link("Read more on site", destination: URL(string: "https://www.xsp.ru/sh/virt/knight.php")!)
            }
            .padding(18)
        }
        .navigationTitle("Рыцарь")
    }
}

struct KnightView_Previews: PreviewProvider {
    static var previews: some View {
        KnightView()
    }
}

extension KnightView {
    var paragraph1: some View {
        VStack(alignment: .leading) {
            Text("Главное - это доброта\n")
                .font(.headline)
            Text("У разных народов мечта о нем (о ней) жила, живет и будет жить. Вот придет, всех пригреет, всех накормит, пожалеет, к сердцу прижмет, защитит от холода, врагов, несправедливости и всякого лиха. Недруги могут иронизировать, смеяться, сравнивать Рыцаря с матерью Терезой, папой Карло, Робин Гудом, Дон Кихотом, Жанной Д'Арк или блаженной Ксенией, и все равно воплощенный образ доброты останется самым востребованным и любимым.\n\nА все потому, что недобрали люди в детстве бабушкиного и дедушкиного тепла, материнской ласки и няниной заботы. Одним словом, мы люди как люди, только ясли и детсады нас испортили.\n\nТаким образом, Рыцарь призван нести в мире холодного расчета и коммерческого оскала первозданную доброту и восполнять нехватку тепла. Как изобразить эту доброту и допустимо ли доброту изображать? Что ж, думается, проблемы тут нет. Огромное число излишне благостных доктрин призывает всех людей стать добряками, держать улыбку, любить всех подряд и так далее. А потому не будет беды, если мы призовем один из семи знаков быть действующим носителем добра и ласки, какие бы черти не сидели у него внутри.\n\nОдаривайте людей лаской, улыбкой, кормите их пирожками, поите чаем, укутывайте теплыми шарфами, ибо образ ваш - это няня, добрая бабушка. Охраняйте людей, оберегайте их от необдуманных поступков, ибо образ ваш - телохранитель, блюститель порядка и покоя.\n\nОпределенная навязчивость и назойливость входят в ассортимент образа, хотя и не всегда вызывают должную оценку людей. Тут же любовь Рыцаря к мелким деталям и подробностям, что рождает иногда мелочность опеки.\n\nИ еще: бесконечные улыбки, безостановочная любовь не могут не привести Рыцаря к истощению. И тогда возможны чудовищные срывы, раскрывается бездна, и наш вечный добряк показывает изнанку образа - жуткий оскал столь же вечного зла.\n\n")
                .foregroundColor(.secondary)
        }
    }
    var paragraph2: some View {
        VStack(alignment: .leading) {
            Text("Одиночество Рыцаря\n")
                .font(.headline)
            Text("Назвался Рыцарем, будь не таким как все, отдели себя от народа, от толпы. Рыцари не могут передвигаться гуртом, одиночество - их удел. Таким образом, противоречие налицо: с одной стороны - надо идти к людям отогревать их, с другой стороны необходимо быть одиноким. Однако проблема может быть легко устранена, если Рыцарь не побоится активно нарушать общественные правила, отделять себя от толпы странными поступками, странным видом, необычными манерами.\n\nТаким образом, Рыцарь просто обязан на себя напялить что-нибудь эдакое, ни на что не похожее. Пример для подражания каждый найдет себе сам (Дон Кихот, Ланселот, Румата…). Не помешает говорить какие-то странные слова и вести себя на грани между нормой и патологией. Иногда странность рождается от стекляности Рыцаря, знаменитого рыцарского зова вечности.\n\nРыцарь не Аристократ, ему народная любовь не так уж и нужна. Здесь игра обратная: Рыцарь несет любовь к народу, но не собирает с народа дань любви.\n\nАкцент на одиночество у Рыцаря происходит именно потому, что сам он не слишком-то рад одиночеству и как бы страдает от него. В этом игра данного образа - все сделать для достижения одиночества и потом на свое же одиночество жаловаться. Мучается от одиночества бессмертный Маклауд, одиноким остается добрейший Румата, улетает на простынях не познав любви Ремедиос Прекрасная.\n\nСтремление к одиночеству неизбежно рождает определенные коммуникативные проблемы. Иногда рыцарское благородство сменяется своей противоположностью, любовью к сплетням, жаждой полного контроля над курируемым человеком. Тяга к подглядыванию точно сочетается с любовью к мелким подробностям и подробной детализации.\n\n")
                .foregroundColor(.secondary)
        }
    }
    var paragraph3: some View {
        VStack(alignment: .leading) {
            Text("А нужен ли подвиг?\n")
                .font(.headline)
            Text("В жизни всегда есть место подвигу. В этом нам не дают усомниться великие Рыцари, реальные или книжные. Чаще всего речь идет о подвиге самопожертвования. Ради семьи, ради любимого человека, ради детей, ради народа или человечества жертвуют своим благополучием, богатством и самой жизнью благородные представители благородного гороскопа. Таковы правила игры и не стоит слишком серьезно разоблачать эти подвиги, не стоит смеяться над попытками Рыцарей свершать эти подвиги. Пусть их.… Впрочем, насмешка над Рыцарем также входит в условия игры, помогая Рыцарю утвердиться в своем одиночестве, косвенно облегчая путь к самопожертвованию.\n\nОдин из главных подвигов в истории человечества - это подвиг любви. Этот подвиг прописан Рыцарю как самый чудодейственный бальзам. Позвольте Рыцарю полюбить кого-то, и он станет самым счастливым человеком на земле.\n\nОни любят, ставят любовь превыше других дел, думают о смысле любви. Не случайно, будучи достаточно средними артистами, многие Рыцари становились очень сильными режиссерами, магистральной темой творчества которых стала любовь.\n\n")
                .foregroundColor(.secondary)
        }
    }
    var paragraph4: some View {
        VStack(alignment: .leading) {
            Text("А вот этого нельзя\n")
                .font(.headline)
            Text("Рыцарю нельзя быть злым или агрессивным (как Вектор), нельзя быть сухим и рациональным (как Профессор), нельзя быть утонченным (как Аристократ), а также шумным и суетливым (как Вождь или Шут).\n\nНа самом деле список запретов столь велик, что фактически не оставляет Рыцарю никакой свободы действий. Может, потому-то они актеры не великие, играть особенно нечего.\n\nИ все же главные запреты не те, что из чужих образов, а свои родовые, рыцарские. Надо утаивать от нужных людей взрывы негативизма, надо утаивать откровенно патологические отклонения в психике, как-то сдерживать свою навязчивость и постараться не слишком мельчить в своих действиях. Длинноват список. Что ж, тем кто пришел в мир творить добро, образ достался не самый выгодный.\n\n")
                .foregroundColor(.secondary)
        }
    }
    var paragraph5: some View {
        VStack(alignment: .leading) {
            Text("Рыцарь на службе и в браке\n")
                .font(.headline)
            Text("Зажатый в тиски образных запретов Рыцарь берет реванш в реальных делах. Этот скромный, тщательный и обязательный знак прекрасный исполнитель, замечательный начальник и очень хороший педагог. Поэтому при всей скромности образа у знака прекрасные служебные перспективы. Кажущаяся бесталанность легко компенсируется стабильностью и надежностью. Начальник ведь не должен быть самым умным, он должен быть самым справедливым, уравновешенным и заботливым, одним словом 'отцом родным'.\n\nПрелесть ситуации еще и в том, что при явном отставании первоначальной оценки от итоговой, Рыцарь практически обречен безостановочно продвигаться вверх. И это очень хорошо.\n\nВ браке Рыцарь не столь уж универсален, предназначенье всего одно - романтический брак, которому так полезны долгие разлуки и вполне соответствует внутреннее одиночество Рыцаря, его тяга к благородному жесту и преклонение перед ритуалом.\n")
                .foregroundColor(.secondary)
        }
    }
}