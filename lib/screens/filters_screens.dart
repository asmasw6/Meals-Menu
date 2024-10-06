import 'package:flutter/material.dart';

class FiltersScreens extends StatefulWidget {
  const FiltersScreens({
    super.key,
    required this.currentFilters,
  });
  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreens> createState() => _FiltersScreensState();
}

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class _FiltersScreensState extends State<FiltersScreens> {
  bool _gluteenFreeFilter = false;
  bool _lactoseFreeFilter = false;
  bool _veganFreeFilter = false;
  bool _vegetarianFreeFilter = false;

@override
  void initState() {
    super.initState();
    _gluteenFreeFilter = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilter = widget.currentFilters[Filter.lactoseFree]!;
    _veganFreeFilter = widget.currentFilters[Filter.vegan]!;
    _vegetarianFreeFilter = widget.currentFilters[Filter.vegetarian]!;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      /*drawer: MainDrawer(
        onSelectScreen: (identifier) {
          Navigator.of(context).pop();
          if (identifier == 'meals') {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const TabsScreen(),
              ),
            );
          }
        },
      ),*/
      body: WillPopScope(
        //canPop: true,
        onWillPop: () async {
          //await Future.delayed(Duration(milliseconds: 100));
          Navigator.of(context).pop({
            Filter.glutenFree: _gluteenFreeFilter,
            Filter.lactoseFree: _lactoseFreeFilter,
            Filter.vegan: _veganFreeFilter,
            Filter.vegetarian: _vegetarianFreeFilter,
          });
          return false;
        },
        child: Column(
          children: [
            customSwitch(
              context,
              "Gluten-free",
              "onlu include gluten-free meals",
              _gluteenFreeFilter,
              (value) => setState(() => _gluteenFreeFilter = value),
            ),
            customSwitch(
              context,
              "Lactose-free",
              "onlu include lactose-free meals",
              _lactoseFreeFilter,
              (value) => setState(() => _lactoseFreeFilter = value),
            ),
            customSwitch(
              context,
              "Vegan",
              "onlu include vegan meals",
              _veganFreeFilter,
              (value) => setState(() => _veganFreeFilter = value),
            ),
            customSwitch(
              context,
              "Vegetarian",
              "onlu include vegetarian meals",
              _vegetarianFreeFilter,
              (value) => setState(() => _vegetarianFreeFilter = value),
            ),
          ],
        ),
      ),
    );
  }

  SwitchListTile customSwitch(BuildContext context, String title,
      String subtitle, bool filter, Function(bool newValue) onChanged) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(
        left: 34,
        right: 22,
      ),
      value: filter,
      onChanged: onChanged,
    );
  }
}
