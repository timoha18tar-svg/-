import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(home: FridgeChef(), debugShowCheckedModeBanner: false),
);

class Recipe {
  final String name;
  final List<String> ingredients;
  final int time;
  final String description;
  final List<String> steps;
  Recipe(this.name, this.ingredients, this.time, this.description, this.steps);
}

class FridgeChef extends StatefulWidget {
  const FridgeChef({super.key});
  @override
  State<FridgeChef> createState() => _FridgeChefState();
}

class _FridgeChefState extends State<FridgeChef> {
  // ЕЩЕ БОЛЬШЕ КРУТЫХ РЕЦЕПТОВ
  final List<Recipe> _recipes = [
    Recipe(
      'Простой Омлет',
      ['Яйца', 'Молоко', 'Сыр'],
      15,
      'Пышный завтрак на скорую руку.',
      [
        '1. Взбейте яйца с молоком и щепоткой соли.',
        '2. Разогрейте сковороду со сливочным маслом.',
        '3. Вылейте смесь и готовьте под крышкой 5-7 минут.',
        '4. Перед концом посыпьте тертым сыром.',
      ],
    ),
    Recipe(
      'Макароны по-флотски',
      ['Макароны', 'Фарш', 'Лук'],
      25,
      'Сытная классика из макарон и фарша.',
      [
        '1. Отварите макароны и слейте воду.',
        '2. Обжарьте мелко нарезанный лук до золотистого цвета.',
        '3. Добавьте к луку фарш, посолите и жарьте 12-15 минут.',
        '4. Смешайте макароны с фаршем в сковороде.',
      ],
    ),
    Recipe(
      'Походный суп с тушёнкой',
      ['Тушёнка', 'Картофель', 'Лук'],
      30,
      'Быстрый наваристый суп.',
      [
        '1. Поставьте кастрюлю с водой на огонь.',
        '2. Нарежьте картофель кубиками и закиньте в кипящую воду.',
        '3. За 10 минут до готовности добавьте тушёнку и обжаренный лук.',
        '4. Посолите по вкусу.',
      ],
    ),
    Recipe(
      'Быстрый Цезарь',
      ['Куриное филе', 'Салат', 'Сыр', 'Майонез'],
      20,
      'Популярный ресторанный салат.',
      [
        '1. Обжарьте кусочки куриного филе до корочки (7-10 минут).',
        '2. Порвите листья салата руками в тарелку.',
        '3. Выложите на салат теплую курицу.',
        '4. Посыпьте сыром и заправьте майонезом.',
      ],
    ),
    Recipe(
      'Жареная картошка',
      ['Картофель', 'Лук'],
      30,
      'Хрустящий картофель с луком.',
      [
        '1. Нарежьте картофель соломкой.',
        '2. Жарьте на среднем огне без крышки, редко переворачивая.',
        '3. За 10 минут до конца добавьте лук и посолите.',
      ],
    ),
    Recipe(
      'Паста Карбонара (Студенческая)',
      ['Макароны', 'Бекон', 'Сливки', 'Сыр', 'Яйца'],
      25,
      'Нежная итальянская паста в сливочном соусе.',
      [
        '1. Отварите макароны.',
        '2. Обжарьте нарезанный бекон на сухой сковороде до хруста.',
        '3. Смешайте сливки, тертый сыр и желток одного яйца.',
        '4. Слейте макароны, пересыпьте к бекону, выключите огонь, залейте соусом и быстро перемешайте.',
      ],
    ),
    Recipe(
      'Сливочный грибной суп',
      ['Грибы', 'Картофель', 'Лук', 'Сливки'],
      35,
      'Ароматный и нежный суп для обеда.',
      [
        '1. Нарежьте грибы и лук, обжарьте на сковороде 10 минут.',
        '2. Сварите нарезанный картофель в кастрюле.',
        '3. Добавьте к картофелю грибы с луком.',
        '4. За 5 минут до конца влейте сливки, посолите и доведите до кипения.',
      ],
    ),
    Recipe(
      'Холостяцкий ужин',
      ['Сосиски', 'Рис', 'Кетчуп'],
      20,
      'Когда нужно приготовить сытно и за 20 минут.',
      [
        '1. Отварите рис в подсоленной воде.',
        '2. Отдельно отварите или обжарьте сосиски.',
        '3. Выложите рис на тарелку, добавьте сосиски и полейте кетчупом.',
      ],
    ),
  ];

  // ЕЩЕ БОЛЬШЕ ПРОДУКТОВ В КАТЕГОРИЯХ
  final Map<String, List<String>> _categories = {
    '🥩 Мясо, Фарш, Колбасы': [
      'Куриное филе',
      'Фарш',
      'Тушёнка',
      'Бекон',
      'Сосиски',
      'Свинина',
    ],
    '🥛 Молочные продукты': [
      'Молоко',
      'Сыр',
      'Сливочное масло',
      'Сливки',
      'Сметана',
    ],
    '🥚 Бакалея и Соусы': [
      'Яйца',
      'Мука',
      'Макароны',
      'Рис',
      'Майонез',
      'Кетчуп',
      'Сахар',
    ],
    '🥦 Овощи и Грибы': [
      'Картофель',
      'Лук',
      'Помидоры',
      'Салат',
      'Грибы',
      'Огурцы',
    ],
  };

  final Map<String, bool> _chosen = {};
  double _timeLimit = 30.0;
  List<Recipe> _perfect = [];
  List<Map<String, dynamic>> _partial = [];
  bool _searched = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    for (var prods in _categories.values) {
      for (var p in prods) {
        _chosen[p] = false;
      }
    }
  }

  void _searchRecipes() {
    List<String> active = [];
    _chosen.forEach((k, v) {
      if (v) active.add(k);
    });
    _perfect.clear();
    _partial.clear();
    for (var r in _recipes) {
      if (r.time > _timeLimit) continue;
      List<String> miss = r.ingredients
          .where((i) => !active.contains(i))
          .toList();
      if (miss.isEmpty) {
        _perfect.add(r);
      } else if (miss.length <= 2) {
        _partial.add({'r': r, 'm': miss});
      }
    }
    setState(() {
      _searched = true;
    });
  }

  void _showRecipeDetails(Recipe recipe) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              recipe.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '⏱️ Время приготовления: ${recipe.time} минут',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const Divider(height: 25),
            const Text(
              '📌 Ингредиенты:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              recipe.ingredients.join(', '),
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
            const Divider(height: 25),
            const Text(
              '🍳 Инструкция по приготовлению:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: recipe.steps
                    .map(
                      (step) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Text(
                          step,
                          style: const TextStyle(fontSize: 15, height: 1.3),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _searched ? 'Результаты поиска' : '🍎 Мой Холодильник',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: _searched
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => setState(() => _searched = false),
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _searched ? _buildResults() : _buildSearch(),
      ),
    );
  }

  Widget _buildSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Поиск продуктов...',
            prefixIcon: const Icon(Icons.search, color: Colors.green),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.green, width: 2),
            ),
          ),
          onChanged: (value) =>
              setState(() => _searchQuery = value.trim().toLowerCase()),
        ),
        const SizedBox(height: 15),
        const Text(
          '1. Что есть в холодильнике:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 5),
        Expanded(
          child: ListView(
            children: _categories.keys.map((cat) {
              List<String> filteredProducts = _categories[cat]!
                  .where(
                    (product) => product.toLowerCase().contains(_searchQuery),
                  )
                  .toList();
              if (filteredProducts.isEmpty) return const SizedBox.shrink();
              return Card(
                key: ValueKey(cat),
                child: ExpansionTile(
                  initiallyExpanded: _searchQuery.isNotEmpty,
                  title: Text(
                    cat,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: filteredProducts
                      .map(
                        (p) => CheckboxListTile(
                          title: Text(p),
                          value: _chosen[p],
                          activeColor: Colors.green,
                          onChanged: (v) =>
                              setState(() => _chosen[p] = v ?? false),
                        ),
                      )
                      .toList(),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '2. Время готовки: ${_timeLimit.round()} мин',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        Slider(
          value: _timeLimit,
          min: 15,
          max: 90,
          divisions: 5,
          label: '${_timeLimit.round()} мин',
          activeColor: Colors.green,
          onChanged: (v) => setState(() => _timeLimit = v),
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            onPressed: _searchRecipes,
            child: const Text(
              'НАЙТИ РЕЦЕПТЫ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResults() {
    if (_perfect.isEmpty && _partial.isEmpty) {
      return const Center(
        child: Text(
          '😢 Под такое время и продукты ничего не нашлось.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      );
    }
    return ListView(
      children: [
        if (_perfect.isNotEmpty) ...[
          const Text(
            '👍 Можно приготовить сейчас:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          ..._perfect.map(
            (r) => Card(
              color: Colors.green.shade50,
              child: ListTile(
                title: Text(
                  r.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${r.description}\n⏱️ Время: ${r.time} мин'),
                trailing: const Icon(Icons.menu_book, color: Colors.green),
                onTap: () => _showRecipeDetails(r),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
        if (_partial.isNotEmpty) ...[
          const Text(
            '🛒 Можно приготовить, если докупить:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          ..._partial.map((item) {
            Recipe r = item['r'];
            List<String> m = item['m'];
            return Card(
              color: Colors.orange.shade50,
              child: ListTile(
                title: Text(
                  r.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '⚠️ Нужно докупить: ${m.join(", ")}\n⏱️ Время: ${r.time} мин',
                ),
                trailing: const Icon(Icons.lock_outline, color: Colors.orange),
                onTap: () => _showRecipeDetails(r),
              ),
            );
          }),
        ],
      ],
    );
  }
}
