import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/providers/filters_provider.dart';

class FiltersScreens extends ConsumerWidget {
  const FiltersScreens({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<dynamic, bool> activeFilters = ref.watch(filterssProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body: Column(
        children: [
          customSwitch(
            context,
            "Gluten-free",
            "only include gluten-free meals",
            activeFilters[Filter.glutenFree]!,
            (value) => ref
                .read(filterssProvider.notifier)
                .setFilter(Filter.glutenFree, value),
          ),
          customSwitch(
            context,
            "Lactose-free",
            "only include lactose-free meals",
            activeFilters[Filter.lactoseFree]!,
            (value) => ref
                .read(filterssProvider.notifier)
                .setFilter(Filter.lactoseFree, value),
          ),
          customSwitch(
            context,
            "Vegan",
            "only include vegan meals",
            activeFilters[Filter.vegan]!,
            (value) => ref
                .read(filterssProvider.notifier)
                .setFilter(Filter.vegan, value),
          ),
          customSwitch(
            context,
            "Vegetarian",
            "only include vegetarian meals",
            activeFilters[Filter.vegetarian]!,
            (value) => ref
                .read(filterssProvider.notifier)
                .setFilter(Filter.vegetarian, value),
          ),
        ],
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
