//
//  VectorView.swift
//  StructuralHoroscope
//
//  Created by Sergei Poluboiarinov on 12.04.2023.
//

import SwiftUI

struct VectorView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                paragraph1
                paragraph2
                paragraph3
                paragraph4
                paragraph5
                Link("Read more on site", destination: URL(string: "https://www.xsp.ru/sh/virt/vector.php")!)
            }
            .padding(18)
        }
        .navigationTitle("Вектор")
    }
}

struct VectorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VectorView()
        }
        .environmentObject(ViewModel())
    }
}

extension VectorView {
    var paragraph1: some View {
        VStack(alignment: .leading) {
            Text("Главное - это беспокойство\n")
                .font(.headline)
            Text("Остальные шесть знаков в той или иной степени демонстрируют равновесие стихий. В Короле уравновешены все возможные стихии, Шут или Вождь имеют минимальное равновесие стихий. Остальные три знака в промежуточном состоянии. А вот Вектор должен, ну просто обязан быть неуравновешенным, в нем баланс стихий разрушен окончательно. Речь, разумеется об образе, имидже человека. Если по какой-то причине образ удалось уравновесить, то дело плохо, векторная энергия хаоса проберется внутрь человека и тогда надо ждать беды, и слова Гете станут звучать по-другому: 'вечно хочет блага, и вечно совершает зло'.\n\nНеуравновешенность Вектора должна сквозить в каждом взгляде, каждом жесте, в словах, глазах, поступках. Он должен быть как голый провод под напряжением, как машина по высеканию искр. При этом Вектор очень далек от неврастении и прочих нервных болезней, нервы у него как канаты. Это не нервность, это какой-то вечный зуд, жажда движения, жажда суеты. Кто-то призван в мир для установки и рождения гармонии и порядка, а кто-то (конечно же, это Вектор) призван излишний порядок уничтожать, рождая хаос. В этом смысле Вектор - идеальная машина по производству хаоса, нечто вроде аппарата по созданию ряда случайных чисел.\n\nТак что главная задача Вектора - беспокоиться самому и заражать своим беспокойством других. При этом самое замечательное, что беспокойство должно быть беспричинным, как бы ни из чего.\n\nМногие Векторы не могут подолгу сидеть на месте, постоянно вскакивают, бегут куда-то. Движения судорожные порывистые или напряженные. В глазах Вектора то ли иголки, то ли искры.\n\n")
                .foregroundColor(.secondary)
        }
    }
    var paragraph2: some View {
        VStack(alignment: .leading) {
            Text("Авантюризм Вектора\n")
                .font(.headline)
            Text("Беспокойство - это так штришок, тип вибрации, реальность образа этой дрожью не создашь. Нужны действия. И действия самого дурного толка.\n\nПростейший вариант образа - это роль воплощенного соблазна для противоположного пола. Такое поведение, при котором нет и намека на обычное дружеское добродушие или рядовое равнодушие, а напротив, сразу возникает мысль о флирте, кокетстве, заигрывании, причем достаточно агрессивного рода. Слова, жесты, взгляды должны без всякой предварительной подготовки буквально пронзать насквозь.\n\nЛюди обыденные, уравновешенные знают, как трудно поддерживать себя в таком агрессивном настрое постоянно. А вот Вектор может играть роль рокового соблазнителя по многу лет и даже десятилетий. Удивительно, но в браке, вопреки своей дурной репутации, Вектор превращается в прекрасного семьянина, очень точно знающего как сохранить семью.\n\nДругой род авантюрного поведения - это склочность, скандальность и интриганство. Все эти качества давным-давно заклеймены человечеством, но что-то не видно, чтобы они пошли на убыль. Что касается стерв и стервоидов, то спрос на них во все времена устойчиво высок. В чем тут дело? А в том, что они нужны. Они не дают людям спать, заводят их, будят. Причем речь идет о любой сфере деятельности - семья, наука, философия, политика.\n\n")
                .foregroundColor(.secondary)
        }
    }
    var paragraph3: some View {
        VStack(alignment: .leading) {
            Text("А стоит ли быть злым гением?\n")
                .font(.headline)
            Text("В каждом коллективе должен быть тот, кто идет против смысла, против логики, против какой-либо планомерности. Его предназначение - крутить, мутить, путать, быть вечным источником смуты. Спрашивается: зачем? А затем, что и скучно и нудно, да и не найти нам никогда истины без таких отчаянных оппонентов как Вектор.\n\nВ любом случае общественная активность Векторов должна быть не меньше чем у Аристократа, но при этом надо бороться не за звание самого белого и пушистого, а, напротив, за звание самого черного и лохматого. Пусть сравнивают с чертями, пусть боятся и вот тогда можно проложив себе дорогу наверх, совершать благо.\n\n")
                .foregroundColor(.secondary)
        }
    }
    var paragraph4: some View {
        VStack(alignment: .leading) {
            Text("А вот этого нельзя\n")
                .font(.headline)
            Text("Легко догадаться, что нельзя быть постным, рациональным, нельзя выглядеть банально, отмалчиваться, отсиживаться, прикидываться таким как все. Нельзя быть планомерным и рациональным.\n\nНельзя сомневаться в своем праве на авантюризм, агрессивность и стервозность. Любые сомнения, нравственные терзания в правомочности подобного образа действий сразу лишают Вектора его магической силы.\n\nИ еще. Нежелательно идти в те сферы, в те места, где торжествуют порядок и гармония, туда, где нет борьбы. Там Вектору карьеры не сделать.\n\n")
                .foregroundColor(.secondary)
        }
    }
    var paragraph5: some View {
        VStack(alignment: .leading) {
            Text("Вектор на службе и в браке\n")
                .font(.headline)
            Text("Пока Вектор рвется к карьерным вершинам, с ним очень трудно совладать. Иногда легче уступить дорогу, чем вступать с ним в борьбу. Добравшись до намеченной цели, Вектор несколько успокаивается и ведет себя достаточно адекватно, защищая своих и воюя с чужими. Хотя подчиненным почти всегда приходится мириться со своеобразием шефа. Методы руководства Вектора не для всех приемлемы.\n\nА вот в браке с Вектором происходит чудо. Сохраняя вне брака буйный нрав, внутри брака Вектор становится так называемым брачным доктором, магическим путем постигает сущность своего брака и ведет себя в нем именно так, чтобы брак укрепился.\n")
                .foregroundColor(.secondary)
        }
    }
}
