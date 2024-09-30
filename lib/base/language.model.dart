part of "_.dart";

/*
  plan
    use the name word, instead of token
    vocabulary is the collection of words, the model understands [has ids, for]
    to create a research-oriented model, the weights, need, to be, much more, accurate
      which is inversely proportional to the vocabulary.word.arr.count
        because if the vocabulary is large
          different prompts, with different, but synonymous words, will lead to different, output
      in the input data
        replace all, the chars' case:upper, with case:lower
        replace all the words, with a common, domain-specific, synonym
        remove the useless words, like "the"
          example: from "in the" to "in"
        remove the {stop|gap}-words, like "in", "to", "of"
          because, their weights' value, have least relevance, hence mere noise
            and only needed, to join, and make sense, of the actual {content|key}-words, forming semantics, providing context, and structure
      the final output, to the prompt's user, should be converted to look like an average, LLM's answer
        as to keep the internal working, a secret */
/*
  weight == sensitivity == attention */

const //
    _string = "unsigned int are bad signed int are good, problem in bitwise operations",
    token__arr = [
      "are",
      "bad", //1
      "bitwise",
      "good", //3
      "in",
      "int", //5
      "operations",
      "problem", //7
      "signed",
      "unsigned", //9
      ","
    ],
    token__id__arr = [9, 5, 0, 1, 8, 5, 0, 3, 10, 7, 4, 2, 6];

void _base__language__model__test() {
  final token__array__count = token__arr.elements__count;

  array__new__generate(
    token__array__count,
    (final i) => token__arr[token__id__arr[i]],
  ).join(' ').print();

  final db = array__new__generate(
    token__array__count,
    (final i) => array__new__fill(
      token__array__count,
      0,
    ),
  );

  base__iterate__reverse__basic(token__array__count, (final i) {
    db[i][token__id__arr[i]] += 1;
  });

  base__iterate__basic(token__array__count, (final i) {
    "$i" "\t${db[i]}" "  ${token__arr[i]}".print();
  });

  token__id__arr.iterate__basic(
    (final _, final token__id_) {
      base__print__blank();
      "${token__arr[token__id_]}:".print();

      base__iterate__basic(token__array__count, (final i) {
        if (db[token__id_][i] > 0) {
          "  ${token__arr[token__id_]}".print();
        }
      });

      "---".print();

      base__iterate__basic(token__array__count, (final i) {
        if (db[i][token__id_] > 0) {
          "  ${token__arr[token__id_]}".print();
        }
      });
    },
  );

  "...".print();

  [
    5,
  ].iterate__basic(
    (final _, final token__id_) {
      base__iterate__basic(token__array__count, (final i) {
        if (db[i][token__id_] > 0) {
          "${token__arr[token__id_]}".print();
        }
      });
    },
  );

  "...".print();

  [
    5,
  ].iterate__basic(
    (final _, final token__id_) {
      base__iterate__basic(token__array__count, (final i) {
        if (db[token__id_][i] > 0) {
          "${token__arr[token__id_]}".print();
        }
      });
    },
  );
}
