/// Returns the [transitive closure][] of [graph].
///
/// [transitive closure]: https://en.wikipedia.org/wiki/Transitive_closure
///
/// Interprets [graph] as a directed graph with a vertex for each key and edges
/// from each key to the values that the key maps to.
///
/// Assumes that every vertex in the graph has a key to represent it, even if
/// that vertex has no outgoing edges. This isn't checked, but if it's not
/// satisfied, the function may crash or provide unexpected output. For example,
/// `{"a": ["b"]}` is not valid, but `{"a": ["b"], "b": []}` is.
Map<T, Set<T>> transitiveClosure<T>(Map<T, Iterable<T>> graph) {
  // This uses [Warshall's algorithm][], modified not to add a vertex from each
  // node to itself.
  //
  // [Warshall's algorithm]: https://en.wikipedia.org/wiki/Floyd%E2%80%93Warshall_algorithm#Applications_and_generalizations.
  var result = <T, Set<T>>{};
  graph.forEach((vertex, edges) {
    result[vertex] = Set<T>.from(edges);
  });

  // Lists are faster to iterate than maps, so we create a list since we're
  // iterating repeatedly.
  var keys = graph.keys.toList();
  for (var vertex1 in keys) {
    for (var vertex2 in keys) {
      for (var vertex3 in keys) {
        if (result[vertex2]!.contains(vertex1) &&
            result[vertex1]!.contains(vertex3)) {
          result[vertex2]!.add(vertex3);
        }
      }
    }
  }

  return result;
}

Map<T, Set<T>> buildReverseDependencyMap<T>(Map<T, Iterable<T>> dependencyMap) {
  // Invert the dependency graph
  final reverseDependencyMap = <T, Set<T>>{};
  dependencyMap.forEach((element, dependencies) {
    for (var dependency in dependencies) {
      reverseDependencyMap.putIfAbsent(dependency, () => {}).add(element);
    }
  });

  // Compute transitive closure on the reversed graph
  return transitiveClosure(reverseDependencyMap);
}

List<T> topologicalSort<T>(Map<T, Iterable<T>> dependencyMap) {
  final visited = <T>{};
  final List<T> sortedOrder = [];

  void visit(T node) {
    if (!visited.add(node)) return; // Skip already visited nodes
    dependencyMap[node]?.forEach(visit);
    sortedOrder.add(node); // Add node after processing dependencies
  }

  dependencyMap.keys.forEach(visit);
  return sortedOrder.reversed.toList(); // Reverse to get correct order
}

///////////////////////////////////////
Iterable<T> dependencyOrderedIterator<T>(
    Map<T, Iterable<T>> reverseDependencyMap) sync* {
  final orderedElements = topologicalSort(reverseDependencyMap);

  for (var element in orderedElements) {
    yield element;
  }
}

/// yield the elements that need re-evaluation
void propagateChange<T>(
    T changedElement, Map<String, Iterable<T>> reverseDependencyMap) /*sync**/ {
  final affectedElements = reverseDependencyMap[changedElement] ?? {};
  final orderedIterator = dependencyOrderedIterator(reverseDependencyMap);

  for (var element in orderedIterator) {
    if (affectedElements.contains(element)) {
    }
  }
}

// temporarily for test
final dependencies = <String, Set<String>>{
  'warehouse': <String>['country'].toSet(),
  'country': <String>['continent', 'transaction'].toSet(),
  'continent': <String>[].toSet(),
  'transaction': <String>['warehouse', 'country'].toSet(),
  // This creates a circular dependency
  'fieldE': <String>['fieldF'].toSet(),
  'fieldF': <String>['transaction'].toSet(),
};

void main() {
  final reverseDepMap3 = buildReverseDependencyMap<String>(dependencies);

  // ///Step 2: Compute the Transitive Closure
  // final closure = dependencyOrderedIterator(reverseDepMap3);

  propagateChange('country', reverseDepMap3);
}
