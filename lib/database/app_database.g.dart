// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MealSuggestionsTable extends MealSuggestions
    with TableInfo<$MealSuggestionsTable, MealSuggestion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealSuggestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _suggestionIdMeta = const VerificationMeta(
    'suggestionId',
  );
  @override
  late final GeneratedColumn<String> suggestionId = GeneratedColumn<String>(
    'suggestion_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealNameMeta = const VerificationMeta(
    'mealName',
  );
  @override
  late final GeneratedColumn<String> mealName = GeneratedColumn<String>(
    'meal_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mealSlotMeta = const VerificationMeta(
    'mealSlot',
  );
  @override
  late final GeneratedColumn<String> mealSlot = GeneratedColumn<String>(
    'meal_slot',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ingredientsMeta = const VerificationMeta(
    'ingredients',
  );
  @override
  late final GeneratedColumn<String> ingredients = GeneratedColumn<String>(
    'ingredients',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _instructionsMeta = const VerificationMeta(
    'instructions',
  );
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
    'instructions',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gutBrainRationaleMeta = const VerificationMeta(
    'gutBrainRationale',
  );
  @override
  late final GeneratedColumn<String> gutBrainRationale =
      GeneratedColumn<String>(
        'gut_brain_rationale',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _promptSnapshotMeta = const VerificationMeta(
    'promptSnapshot',
  );
  @override
  late final GeneratedColumn<String> promptSnapshot = GeneratedColumn<String>(
    'prompt_snapshot',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rawResponseJsonMeta = const VerificationMeta(
    'rawResponseJson',
  );
  @override
  late final GeneratedColumn<String> rawResponseJson = GeneratedColumn<String>(
    'raw_response_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetsConditionMeta = const VerificationMeta(
    'targetsCondition',
  );
  @override
  late final GeneratedColumn<String> targetsCondition = GeneratedColumn<String>(
    'targets_condition',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _requestedAtMeta = const VerificationMeta(
    'requestedAt',
  );
  @override
  late final GeneratedColumn<String> requestedAt = GeneratedColumn<String>(
    'requested_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userAcceptedMeta = const VerificationMeta(
    'userAccepted',
  );
  @override
  late final GeneratedColumn<int> userAccepted = GeneratedColumn<int>(
    'user_accepted',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _stateIdMeta = const VerificationMeta(
    'stateId',
  );
  @override
  late final GeneratedColumn<String> stateId = GeneratedColumn<String>(
    'state_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fermentedServingsMeta = const VerificationMeta(
    'fermentedServings',
  );
  @override
  late final GeneratedColumn<double> fermentedServings =
      GeneratedColumn<double>(
        'fermented_servings',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _magnesiumMgMeta = const VerificationMeta(
    'magnesiumMg',
  );
  @override
  late final GeneratedColumn<double> magnesiumMg = GeneratedColumn<double>(
    'magnesium_mg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _omega3GMeta = const VerificationMeta(
    'omega3G',
  );
  @override
  late final GeneratedColumn<double> omega3G = GeneratedColumn<double>(
    'omega3_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _plantSpeciesCountMeta = const VerificationMeta(
    'plantSpeciesCount',
  );
  @override
  late final GeneratedColumn<int> plantSpeciesCount = GeneratedColumn<int>(
    'plant_species_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _prebioticFiberGMeta = const VerificationMeta(
    'prebioticFiberG',
  );
  @override
  late final GeneratedColumn<double> prebioticFiberG = GeneratedColumn<double>(
    'prebiotic_fiber_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tryptophanMgMeta = const VerificationMeta(
    'tryptophanMg',
  );
  @override
  late final GeneratedColumn<double> tryptophanMg = GeneratedColumn<double>(
    'tryptophan_mg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    suggestionId,
    userId,
    mealName,
    mealSlot,
    ingredients,
    instructions,
    gutBrainRationale,
    promptSnapshot,
    rawResponseJson,
    targetsCondition,
    requestedAt,
    userAccepted,
    stateId,
    fermentedServings,
    magnesiumMg,
    omega3G,
    plantSpeciesCount,
    prebioticFiberG,
    tryptophanMg,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_suggestions';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealSuggestion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('suggestion_id')) {
      context.handle(
        _suggestionIdMeta,
        suggestionId.isAcceptableOrUnknown(
          data['suggestion_id']!,
          _suggestionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_suggestionIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('meal_name')) {
      context.handle(
        _mealNameMeta,
        mealName.isAcceptableOrUnknown(data['meal_name']!, _mealNameMeta),
      );
    }
    if (data.containsKey('meal_slot')) {
      context.handle(
        _mealSlotMeta,
        mealSlot.isAcceptableOrUnknown(data['meal_slot']!, _mealSlotMeta),
      );
    }
    if (data.containsKey('ingredients')) {
      context.handle(
        _ingredientsMeta,
        ingredients.isAcceptableOrUnknown(
          data['ingredients']!,
          _ingredientsMeta,
        ),
      );
    }
    if (data.containsKey('instructions')) {
      context.handle(
        _instructionsMeta,
        instructions.isAcceptableOrUnknown(
          data['instructions']!,
          _instructionsMeta,
        ),
      );
    }
    if (data.containsKey('gut_brain_rationale')) {
      context.handle(
        _gutBrainRationaleMeta,
        gutBrainRationale.isAcceptableOrUnknown(
          data['gut_brain_rationale']!,
          _gutBrainRationaleMeta,
        ),
      );
    }
    if (data.containsKey('prompt_snapshot')) {
      context.handle(
        _promptSnapshotMeta,
        promptSnapshot.isAcceptableOrUnknown(
          data['prompt_snapshot']!,
          _promptSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('raw_response_json')) {
      context.handle(
        _rawResponseJsonMeta,
        rawResponseJson.isAcceptableOrUnknown(
          data['raw_response_json']!,
          _rawResponseJsonMeta,
        ),
      );
    }
    if (data.containsKey('targets_condition')) {
      context.handle(
        _targetsConditionMeta,
        targetsCondition.isAcceptableOrUnknown(
          data['targets_condition']!,
          _targetsConditionMeta,
        ),
      );
    }
    if (data.containsKey('requested_at')) {
      context.handle(
        _requestedAtMeta,
        requestedAt.isAcceptableOrUnknown(
          data['requested_at']!,
          _requestedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requestedAtMeta);
    }
    if (data.containsKey('user_accepted')) {
      context.handle(
        _userAcceptedMeta,
        userAccepted.isAcceptableOrUnknown(
          data['user_accepted']!,
          _userAcceptedMeta,
        ),
      );
    }
    if (data.containsKey('state_id')) {
      context.handle(
        _stateIdMeta,
        stateId.isAcceptableOrUnknown(data['state_id']!, _stateIdMeta),
      );
    }
    if (data.containsKey('fermented_servings')) {
      context.handle(
        _fermentedServingsMeta,
        fermentedServings.isAcceptableOrUnknown(
          data['fermented_servings']!,
          _fermentedServingsMeta,
        ),
      );
    }
    if (data.containsKey('magnesium_mg')) {
      context.handle(
        _magnesiumMgMeta,
        magnesiumMg.isAcceptableOrUnknown(
          data['magnesium_mg']!,
          _magnesiumMgMeta,
        ),
      );
    }
    if (data.containsKey('omega3_g')) {
      context.handle(
        _omega3GMeta,
        omega3G.isAcceptableOrUnknown(data['omega3_g']!, _omega3GMeta),
      );
    }
    if (data.containsKey('plant_species_count')) {
      context.handle(
        _plantSpeciesCountMeta,
        plantSpeciesCount.isAcceptableOrUnknown(
          data['plant_species_count']!,
          _plantSpeciesCountMeta,
        ),
      );
    }
    if (data.containsKey('prebiotic_fiber_g')) {
      context.handle(
        _prebioticFiberGMeta,
        prebioticFiberG.isAcceptableOrUnknown(
          data['prebiotic_fiber_g']!,
          _prebioticFiberGMeta,
        ),
      );
    }
    if (data.containsKey('tryptophan_mg')) {
      context.handle(
        _tryptophanMgMeta,
        tryptophanMg.isAcceptableOrUnknown(
          data['tryptophan_mg']!,
          _tryptophanMgMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {suggestionId};
  @override
  MealSuggestion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealSuggestion(
      suggestionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}suggestion_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      mealName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_name'],
      ),
      mealSlot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_slot'],
      ),
      ingredients: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredients'],
      ),
      instructions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instructions'],
      ),
      gutBrainRationale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gut_brain_rationale'],
      ),
      promptSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt_snapshot'],
      ),
      rawResponseJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_response_json'],
      ),
      targetsCondition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}targets_condition'],
      ),
      requestedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}requested_at'],
      )!,
      userAccepted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_accepted'],
      )!,
      stateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state_id'],
      ),
      fermentedServings: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fermented_servings'],
      ),
      magnesiumMg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}magnesium_mg'],
      ),
      omega3G: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}omega3_g'],
      ),
      plantSpeciesCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plant_species_count'],
      ),
      prebioticFiberG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}prebiotic_fiber_g'],
      ),
      tryptophanMg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tryptophan_mg'],
      ),
    );
  }

  @override
  $MealSuggestionsTable createAlias(String alias) {
    return $MealSuggestionsTable(attachedDatabase, alias);
  }
}

class MealSuggestion extends DataClass implements Insertable<MealSuggestion> {
  final String suggestionId;
  final String userId;
  final String? mealName;
  final String? mealSlot;

  /// JSON-encoded list of ingredients.
  final String? ingredients;
  final String? instructions;
  final String? gutBrainRationale;

  /// JSON snapshot of the prompt used to generate this suggestion.
  final String? promptSnapshot;

  /// Raw JSON response from the AI model.
  final String? rawResponseJson;
  final String? targetsCondition;
  final String requestedAt;

  /// 1 = accepted / not yet acted on, 0 = rejected.
  final int userAccepted;
  final String? stateId;
  final double? fermentedServings;
  final double? magnesiumMg;
  final double? omega3G;
  final int? plantSpeciesCount;
  final double? prebioticFiberG;
  final double? tryptophanMg;
  const MealSuggestion({
    required this.suggestionId,
    required this.userId,
    this.mealName,
    this.mealSlot,
    this.ingredients,
    this.instructions,
    this.gutBrainRationale,
    this.promptSnapshot,
    this.rawResponseJson,
    this.targetsCondition,
    required this.requestedAt,
    required this.userAccepted,
    this.stateId,
    this.fermentedServings,
    this.magnesiumMg,
    this.omega3G,
    this.plantSpeciesCount,
    this.prebioticFiberG,
    this.tryptophanMg,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['suggestion_id'] = Variable<String>(suggestionId);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || mealName != null) {
      map['meal_name'] = Variable<String>(mealName);
    }
    if (!nullToAbsent || mealSlot != null) {
      map['meal_slot'] = Variable<String>(mealSlot);
    }
    if (!nullToAbsent || ingredients != null) {
      map['ingredients'] = Variable<String>(ingredients);
    }
    if (!nullToAbsent || instructions != null) {
      map['instructions'] = Variable<String>(instructions);
    }
    if (!nullToAbsent || gutBrainRationale != null) {
      map['gut_brain_rationale'] = Variable<String>(gutBrainRationale);
    }
    if (!nullToAbsent || promptSnapshot != null) {
      map['prompt_snapshot'] = Variable<String>(promptSnapshot);
    }
    if (!nullToAbsent || rawResponseJson != null) {
      map['raw_response_json'] = Variable<String>(rawResponseJson);
    }
    if (!nullToAbsent || targetsCondition != null) {
      map['targets_condition'] = Variable<String>(targetsCondition);
    }
    map['requested_at'] = Variable<String>(requestedAt);
    map['user_accepted'] = Variable<int>(userAccepted);
    if (!nullToAbsent || stateId != null) {
      map['state_id'] = Variable<String>(stateId);
    }
    if (!nullToAbsent || fermentedServings != null) {
      map['fermented_servings'] = Variable<double>(fermentedServings);
    }
    if (!nullToAbsent || magnesiumMg != null) {
      map['magnesium_mg'] = Variable<double>(magnesiumMg);
    }
    if (!nullToAbsent || omega3G != null) {
      map['omega3_g'] = Variable<double>(omega3G);
    }
    if (!nullToAbsent || plantSpeciesCount != null) {
      map['plant_species_count'] = Variable<int>(plantSpeciesCount);
    }
    if (!nullToAbsent || prebioticFiberG != null) {
      map['prebiotic_fiber_g'] = Variable<double>(prebioticFiberG);
    }
    if (!nullToAbsent || tryptophanMg != null) {
      map['tryptophan_mg'] = Variable<double>(tryptophanMg);
    }
    return map;
  }

  MealSuggestionsCompanion toCompanion(bool nullToAbsent) {
    return MealSuggestionsCompanion(
      suggestionId: Value(suggestionId),
      userId: Value(userId),
      mealName: mealName == null && nullToAbsent
          ? const Value.absent()
          : Value(mealName),
      mealSlot: mealSlot == null && nullToAbsent
          ? const Value.absent()
          : Value(mealSlot),
      ingredients: ingredients == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredients),
      instructions: instructions == null && nullToAbsent
          ? const Value.absent()
          : Value(instructions),
      gutBrainRationale: gutBrainRationale == null && nullToAbsent
          ? const Value.absent()
          : Value(gutBrainRationale),
      promptSnapshot: promptSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(promptSnapshot),
      rawResponseJson: rawResponseJson == null && nullToAbsent
          ? const Value.absent()
          : Value(rawResponseJson),
      targetsCondition: targetsCondition == null && nullToAbsent
          ? const Value.absent()
          : Value(targetsCondition),
      requestedAt: Value(requestedAt),
      userAccepted: Value(userAccepted),
      stateId: stateId == null && nullToAbsent
          ? const Value.absent()
          : Value(stateId),
      fermentedServings: fermentedServings == null && nullToAbsent
          ? const Value.absent()
          : Value(fermentedServings),
      magnesiumMg: magnesiumMg == null && nullToAbsent
          ? const Value.absent()
          : Value(magnesiumMg),
      omega3G: omega3G == null && nullToAbsent
          ? const Value.absent()
          : Value(omega3G),
      plantSpeciesCount: plantSpeciesCount == null && nullToAbsent
          ? const Value.absent()
          : Value(plantSpeciesCount),
      prebioticFiberG: prebioticFiberG == null && nullToAbsent
          ? const Value.absent()
          : Value(prebioticFiberG),
      tryptophanMg: tryptophanMg == null && nullToAbsent
          ? const Value.absent()
          : Value(tryptophanMg),
    );
  }

  factory MealSuggestion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealSuggestion(
      suggestionId: serializer.fromJson<String>(json['suggestionId']),
      userId: serializer.fromJson<String>(json['userId']),
      mealName: serializer.fromJson<String?>(json['mealName']),
      mealSlot: serializer.fromJson<String?>(json['mealSlot']),
      ingredients: serializer.fromJson<String?>(json['ingredients']),
      instructions: serializer.fromJson<String?>(json['instructions']),
      gutBrainRationale: serializer.fromJson<String?>(
        json['gutBrainRationale'],
      ),
      promptSnapshot: serializer.fromJson<String?>(json['promptSnapshot']),
      rawResponseJson: serializer.fromJson<String?>(json['rawResponseJson']),
      targetsCondition: serializer.fromJson<String?>(json['targetsCondition']),
      requestedAt: serializer.fromJson<String>(json['requestedAt']),
      userAccepted: serializer.fromJson<int>(json['userAccepted']),
      stateId: serializer.fromJson<String?>(json['stateId']),
      fermentedServings: serializer.fromJson<double?>(
        json['fermentedServings'],
      ),
      magnesiumMg: serializer.fromJson<double?>(json['magnesiumMg']),
      omega3G: serializer.fromJson<double?>(json['omega3G']),
      plantSpeciesCount: serializer.fromJson<int?>(json['plantSpeciesCount']),
      prebioticFiberG: serializer.fromJson<double?>(json['prebioticFiberG']),
      tryptophanMg: serializer.fromJson<double?>(json['tryptophanMg']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'suggestionId': serializer.toJson<String>(suggestionId),
      'userId': serializer.toJson<String>(userId),
      'mealName': serializer.toJson<String?>(mealName),
      'mealSlot': serializer.toJson<String?>(mealSlot),
      'ingredients': serializer.toJson<String?>(ingredients),
      'instructions': serializer.toJson<String?>(instructions),
      'gutBrainRationale': serializer.toJson<String?>(gutBrainRationale),
      'promptSnapshot': serializer.toJson<String?>(promptSnapshot),
      'rawResponseJson': serializer.toJson<String?>(rawResponseJson),
      'targetsCondition': serializer.toJson<String?>(targetsCondition),
      'requestedAt': serializer.toJson<String>(requestedAt),
      'userAccepted': serializer.toJson<int>(userAccepted),
      'stateId': serializer.toJson<String?>(stateId),
      'fermentedServings': serializer.toJson<double?>(fermentedServings),
      'magnesiumMg': serializer.toJson<double?>(magnesiumMg),
      'omega3G': serializer.toJson<double?>(omega3G),
      'plantSpeciesCount': serializer.toJson<int?>(plantSpeciesCount),
      'prebioticFiberG': serializer.toJson<double?>(prebioticFiberG),
      'tryptophanMg': serializer.toJson<double?>(tryptophanMg),
    };
  }

  MealSuggestion copyWith({
    String? suggestionId,
    String? userId,
    Value<String?> mealName = const Value.absent(),
    Value<String?> mealSlot = const Value.absent(),
    Value<String?> ingredients = const Value.absent(),
    Value<String?> instructions = const Value.absent(),
    Value<String?> gutBrainRationale = const Value.absent(),
    Value<String?> promptSnapshot = const Value.absent(),
    Value<String?> rawResponseJson = const Value.absent(),
    Value<String?> targetsCondition = const Value.absent(),
    String? requestedAt,
    int? userAccepted,
    Value<String?> stateId = const Value.absent(),
    Value<double?> fermentedServings = const Value.absent(),
    Value<double?> magnesiumMg = const Value.absent(),
    Value<double?> omega3G = const Value.absent(),
    Value<int?> plantSpeciesCount = const Value.absent(),
    Value<double?> prebioticFiberG = const Value.absent(),
    Value<double?> tryptophanMg = const Value.absent(),
  }) => MealSuggestion(
    suggestionId: suggestionId ?? this.suggestionId,
    userId: userId ?? this.userId,
    mealName: mealName.present ? mealName.value : this.mealName,
    mealSlot: mealSlot.present ? mealSlot.value : this.mealSlot,
    ingredients: ingredients.present ? ingredients.value : this.ingredients,
    instructions: instructions.present ? instructions.value : this.instructions,
    gutBrainRationale: gutBrainRationale.present
        ? gutBrainRationale.value
        : this.gutBrainRationale,
    promptSnapshot: promptSnapshot.present
        ? promptSnapshot.value
        : this.promptSnapshot,
    rawResponseJson: rawResponseJson.present
        ? rawResponseJson.value
        : this.rawResponseJson,
    targetsCondition: targetsCondition.present
        ? targetsCondition.value
        : this.targetsCondition,
    requestedAt: requestedAt ?? this.requestedAt,
    userAccepted: userAccepted ?? this.userAccepted,
    stateId: stateId.present ? stateId.value : this.stateId,
    fermentedServings: fermentedServings.present
        ? fermentedServings.value
        : this.fermentedServings,
    magnesiumMg: magnesiumMg.present ? magnesiumMg.value : this.magnesiumMg,
    omega3G: omega3G.present ? omega3G.value : this.omega3G,
    plantSpeciesCount: plantSpeciesCount.present
        ? plantSpeciesCount.value
        : this.plantSpeciesCount,
    prebioticFiberG: prebioticFiberG.present
        ? prebioticFiberG.value
        : this.prebioticFiberG,
    tryptophanMg: tryptophanMg.present ? tryptophanMg.value : this.tryptophanMg,
  );
  MealSuggestion copyWithCompanion(MealSuggestionsCompanion data) {
    return MealSuggestion(
      suggestionId: data.suggestionId.present
          ? data.suggestionId.value
          : this.suggestionId,
      userId: data.userId.present ? data.userId.value : this.userId,
      mealName: data.mealName.present ? data.mealName.value : this.mealName,
      mealSlot: data.mealSlot.present ? data.mealSlot.value : this.mealSlot,
      ingredients: data.ingredients.present
          ? data.ingredients.value
          : this.ingredients,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
      gutBrainRationale: data.gutBrainRationale.present
          ? data.gutBrainRationale.value
          : this.gutBrainRationale,
      promptSnapshot: data.promptSnapshot.present
          ? data.promptSnapshot.value
          : this.promptSnapshot,
      rawResponseJson: data.rawResponseJson.present
          ? data.rawResponseJson.value
          : this.rawResponseJson,
      targetsCondition: data.targetsCondition.present
          ? data.targetsCondition.value
          : this.targetsCondition,
      requestedAt: data.requestedAt.present
          ? data.requestedAt.value
          : this.requestedAt,
      userAccepted: data.userAccepted.present
          ? data.userAccepted.value
          : this.userAccepted,
      stateId: data.stateId.present ? data.stateId.value : this.stateId,
      fermentedServings: data.fermentedServings.present
          ? data.fermentedServings.value
          : this.fermentedServings,
      magnesiumMg: data.magnesiumMg.present
          ? data.magnesiumMg.value
          : this.magnesiumMg,
      omega3G: data.omega3G.present ? data.omega3G.value : this.omega3G,
      plantSpeciesCount: data.plantSpeciesCount.present
          ? data.plantSpeciesCount.value
          : this.plantSpeciesCount,
      prebioticFiberG: data.prebioticFiberG.present
          ? data.prebioticFiberG.value
          : this.prebioticFiberG,
      tryptophanMg: data.tryptophanMg.present
          ? data.tryptophanMg.value
          : this.tryptophanMg,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealSuggestion(')
          ..write('suggestionId: $suggestionId, ')
          ..write('userId: $userId, ')
          ..write('mealName: $mealName, ')
          ..write('mealSlot: $mealSlot, ')
          ..write('ingredients: $ingredients, ')
          ..write('instructions: $instructions, ')
          ..write('gutBrainRationale: $gutBrainRationale, ')
          ..write('promptSnapshot: $promptSnapshot, ')
          ..write('rawResponseJson: $rawResponseJson, ')
          ..write('targetsCondition: $targetsCondition, ')
          ..write('requestedAt: $requestedAt, ')
          ..write('userAccepted: $userAccepted, ')
          ..write('stateId: $stateId, ')
          ..write('fermentedServings: $fermentedServings, ')
          ..write('magnesiumMg: $magnesiumMg, ')
          ..write('omega3G: $omega3G, ')
          ..write('plantSpeciesCount: $plantSpeciesCount, ')
          ..write('prebioticFiberG: $prebioticFiberG, ')
          ..write('tryptophanMg: $tryptophanMg')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    suggestionId,
    userId,
    mealName,
    mealSlot,
    ingredients,
    instructions,
    gutBrainRationale,
    promptSnapshot,
    rawResponseJson,
    targetsCondition,
    requestedAt,
    userAccepted,
    stateId,
    fermentedServings,
    magnesiumMg,
    omega3G,
    plantSpeciesCount,
    prebioticFiberG,
    tryptophanMg,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealSuggestion &&
          other.suggestionId == this.suggestionId &&
          other.userId == this.userId &&
          other.mealName == this.mealName &&
          other.mealSlot == this.mealSlot &&
          other.ingredients == this.ingredients &&
          other.instructions == this.instructions &&
          other.gutBrainRationale == this.gutBrainRationale &&
          other.promptSnapshot == this.promptSnapshot &&
          other.rawResponseJson == this.rawResponseJson &&
          other.targetsCondition == this.targetsCondition &&
          other.requestedAt == this.requestedAt &&
          other.userAccepted == this.userAccepted &&
          other.stateId == this.stateId &&
          other.fermentedServings == this.fermentedServings &&
          other.magnesiumMg == this.magnesiumMg &&
          other.omega3G == this.omega3G &&
          other.plantSpeciesCount == this.plantSpeciesCount &&
          other.prebioticFiberG == this.prebioticFiberG &&
          other.tryptophanMg == this.tryptophanMg);
}

class MealSuggestionsCompanion extends UpdateCompanion<MealSuggestion> {
  final Value<String> suggestionId;
  final Value<String> userId;
  final Value<String?> mealName;
  final Value<String?> mealSlot;
  final Value<String?> ingredients;
  final Value<String?> instructions;
  final Value<String?> gutBrainRationale;
  final Value<String?> promptSnapshot;
  final Value<String?> rawResponseJson;
  final Value<String?> targetsCondition;
  final Value<String> requestedAt;
  final Value<int> userAccepted;
  final Value<String?> stateId;
  final Value<double?> fermentedServings;
  final Value<double?> magnesiumMg;
  final Value<double?> omega3G;
  final Value<int?> plantSpeciesCount;
  final Value<double?> prebioticFiberG;
  final Value<double?> tryptophanMg;
  final Value<int> rowid;
  const MealSuggestionsCompanion({
    this.suggestionId = const Value.absent(),
    this.userId = const Value.absent(),
    this.mealName = const Value.absent(),
    this.mealSlot = const Value.absent(),
    this.ingredients = const Value.absent(),
    this.instructions = const Value.absent(),
    this.gutBrainRationale = const Value.absent(),
    this.promptSnapshot = const Value.absent(),
    this.rawResponseJson = const Value.absent(),
    this.targetsCondition = const Value.absent(),
    this.requestedAt = const Value.absent(),
    this.userAccepted = const Value.absent(),
    this.stateId = const Value.absent(),
    this.fermentedServings = const Value.absent(),
    this.magnesiumMg = const Value.absent(),
    this.omega3G = const Value.absent(),
    this.plantSpeciesCount = const Value.absent(),
    this.prebioticFiberG = const Value.absent(),
    this.tryptophanMg = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MealSuggestionsCompanion.insert({
    required String suggestionId,
    required String userId,
    this.mealName = const Value.absent(),
    this.mealSlot = const Value.absent(),
    this.ingredients = const Value.absent(),
    this.instructions = const Value.absent(),
    this.gutBrainRationale = const Value.absent(),
    this.promptSnapshot = const Value.absent(),
    this.rawResponseJson = const Value.absent(),
    this.targetsCondition = const Value.absent(),
    required String requestedAt,
    this.userAccepted = const Value.absent(),
    this.stateId = const Value.absent(),
    this.fermentedServings = const Value.absent(),
    this.magnesiumMg = const Value.absent(),
    this.omega3G = const Value.absent(),
    this.plantSpeciesCount = const Value.absent(),
    this.prebioticFiberG = const Value.absent(),
    this.tryptophanMg = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : suggestionId = Value(suggestionId),
       userId = Value(userId),
       requestedAt = Value(requestedAt);
  static Insertable<MealSuggestion> custom({
    Expression<String>? suggestionId,
    Expression<String>? userId,
    Expression<String>? mealName,
    Expression<String>? mealSlot,
    Expression<String>? ingredients,
    Expression<String>? instructions,
    Expression<String>? gutBrainRationale,
    Expression<String>? promptSnapshot,
    Expression<String>? rawResponseJson,
    Expression<String>? targetsCondition,
    Expression<String>? requestedAt,
    Expression<int>? userAccepted,
    Expression<String>? stateId,
    Expression<double>? fermentedServings,
    Expression<double>? magnesiumMg,
    Expression<double>? omega3G,
    Expression<int>? plantSpeciesCount,
    Expression<double>? prebioticFiberG,
    Expression<double>? tryptophanMg,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (suggestionId != null) 'suggestion_id': suggestionId,
      if (userId != null) 'user_id': userId,
      if (mealName != null) 'meal_name': mealName,
      if (mealSlot != null) 'meal_slot': mealSlot,
      if (ingredients != null) 'ingredients': ingredients,
      if (instructions != null) 'instructions': instructions,
      if (gutBrainRationale != null) 'gut_brain_rationale': gutBrainRationale,
      if (promptSnapshot != null) 'prompt_snapshot': promptSnapshot,
      if (rawResponseJson != null) 'raw_response_json': rawResponseJson,
      if (targetsCondition != null) 'targets_condition': targetsCondition,
      if (requestedAt != null) 'requested_at': requestedAt,
      if (userAccepted != null) 'user_accepted': userAccepted,
      if (stateId != null) 'state_id': stateId,
      if (fermentedServings != null) 'fermented_servings': fermentedServings,
      if (magnesiumMg != null) 'magnesium_mg': magnesiumMg,
      if (omega3G != null) 'omega3_g': omega3G,
      if (plantSpeciesCount != null) 'plant_species_count': plantSpeciesCount,
      if (prebioticFiberG != null) 'prebiotic_fiber_g': prebioticFiberG,
      if (tryptophanMg != null) 'tryptophan_mg': tryptophanMg,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MealSuggestionsCompanion copyWith({
    Value<String>? suggestionId,
    Value<String>? userId,
    Value<String?>? mealName,
    Value<String?>? mealSlot,
    Value<String?>? ingredients,
    Value<String?>? instructions,
    Value<String?>? gutBrainRationale,
    Value<String?>? promptSnapshot,
    Value<String?>? rawResponseJson,
    Value<String?>? targetsCondition,
    Value<String>? requestedAt,
    Value<int>? userAccepted,
    Value<String?>? stateId,
    Value<double?>? fermentedServings,
    Value<double?>? magnesiumMg,
    Value<double?>? omega3G,
    Value<int?>? plantSpeciesCount,
    Value<double?>? prebioticFiberG,
    Value<double?>? tryptophanMg,
    Value<int>? rowid,
  }) {
    return MealSuggestionsCompanion(
      suggestionId: suggestionId ?? this.suggestionId,
      userId: userId ?? this.userId,
      mealName: mealName ?? this.mealName,
      mealSlot: mealSlot ?? this.mealSlot,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      gutBrainRationale: gutBrainRationale ?? this.gutBrainRationale,
      promptSnapshot: promptSnapshot ?? this.promptSnapshot,
      rawResponseJson: rawResponseJson ?? this.rawResponseJson,
      targetsCondition: targetsCondition ?? this.targetsCondition,
      requestedAt: requestedAt ?? this.requestedAt,
      userAccepted: userAccepted ?? this.userAccepted,
      stateId: stateId ?? this.stateId,
      fermentedServings: fermentedServings ?? this.fermentedServings,
      magnesiumMg: magnesiumMg ?? this.magnesiumMg,
      omega3G: omega3G ?? this.omega3G,
      plantSpeciesCount: plantSpeciesCount ?? this.plantSpeciesCount,
      prebioticFiberG: prebioticFiberG ?? this.prebioticFiberG,
      tryptophanMg: tryptophanMg ?? this.tryptophanMg,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (suggestionId.present) {
      map['suggestion_id'] = Variable<String>(suggestionId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (mealName.present) {
      map['meal_name'] = Variable<String>(mealName.value);
    }
    if (mealSlot.present) {
      map['meal_slot'] = Variable<String>(mealSlot.value);
    }
    if (ingredients.present) {
      map['ingredients'] = Variable<String>(ingredients.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    if (gutBrainRationale.present) {
      map['gut_brain_rationale'] = Variable<String>(gutBrainRationale.value);
    }
    if (promptSnapshot.present) {
      map['prompt_snapshot'] = Variable<String>(promptSnapshot.value);
    }
    if (rawResponseJson.present) {
      map['raw_response_json'] = Variable<String>(rawResponseJson.value);
    }
    if (targetsCondition.present) {
      map['targets_condition'] = Variable<String>(targetsCondition.value);
    }
    if (requestedAt.present) {
      map['requested_at'] = Variable<String>(requestedAt.value);
    }
    if (userAccepted.present) {
      map['user_accepted'] = Variable<int>(userAccepted.value);
    }
    if (stateId.present) {
      map['state_id'] = Variable<String>(stateId.value);
    }
    if (fermentedServings.present) {
      map['fermented_servings'] = Variable<double>(fermentedServings.value);
    }
    if (magnesiumMg.present) {
      map['magnesium_mg'] = Variable<double>(magnesiumMg.value);
    }
    if (omega3G.present) {
      map['omega3_g'] = Variable<double>(omega3G.value);
    }
    if (plantSpeciesCount.present) {
      map['plant_species_count'] = Variable<int>(plantSpeciesCount.value);
    }
    if (prebioticFiberG.present) {
      map['prebiotic_fiber_g'] = Variable<double>(prebioticFiberG.value);
    }
    if (tryptophanMg.present) {
      map['tryptophan_mg'] = Variable<double>(tryptophanMg.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealSuggestionsCompanion(')
          ..write('suggestionId: $suggestionId, ')
          ..write('userId: $userId, ')
          ..write('mealName: $mealName, ')
          ..write('mealSlot: $mealSlot, ')
          ..write('ingredients: $ingredients, ')
          ..write('instructions: $instructions, ')
          ..write('gutBrainRationale: $gutBrainRationale, ')
          ..write('promptSnapshot: $promptSnapshot, ')
          ..write('rawResponseJson: $rawResponseJson, ')
          ..write('targetsCondition: $targetsCondition, ')
          ..write('requestedAt: $requestedAt, ')
          ..write('userAccepted: $userAccepted, ')
          ..write('stateId: $stateId, ')
          ..write('fermentedServings: $fermentedServings, ')
          ..write('magnesiumMg: $magnesiumMg, ')
          ..write('omega3G: $omega3G, ')
          ..write('plantSpeciesCount: $plantSpeciesCount, ')
          ..write('prebioticFiberG: $prebioticFiberG, ')
          ..write('tryptophanMg: $tryptophanMg, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MealsTable extends Meals with TableInfo<$MealsTable, Meal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _mealIdMeta = const VerificationMeta('mealId');
  @override
  late final GeneratedColumn<String> mealId = GeneratedColumn<String>(
    'meal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _suggestionIdMeta = const VerificationMeta(
    'suggestionId',
  );
  @override
  late final GeneratedColumn<String> suggestionId = GeneratedColumn<String>(
    'suggestion_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meal_suggestions (suggestion_id)',
    ),
  );
  static const VerificationMeta _mealNameMeta = const VerificationMeta(
    'mealName',
  );
  @override
  late final GeneratedColumn<String> mealName = GeneratedColumn<String>(
    'meal_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mealSlotMeta = const VerificationMeta(
    'mealSlot',
  );
  @override
  late final GeneratedColumn<String> mealSlot = GeneratedColumn<String>(
    'meal_slot',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _plantSpeciesCountMeta = const VerificationMeta(
    'plantSpeciesCount',
  );
  @override
  late final GeneratedColumn<int> plantSpeciesCount = GeneratedColumn<int>(
    'plant_species_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _plantSpeciesListMeta = const VerificationMeta(
    'plantSpeciesList',
  );
  @override
  late final GeneratedColumn<String> plantSpeciesList = GeneratedColumn<String>(
    'plant_species_list',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fermentedServingsMeta = const VerificationMeta(
    'fermentedServings',
  );
  @override
  late final GeneratedColumn<double> fermentedServings =
      GeneratedColumn<double>(
        'fermented_servings',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _magnesiumMgMeta = const VerificationMeta(
    'magnesiumMg',
  );
  @override
  late final GeneratedColumn<double> magnesiumMg = GeneratedColumn<double>(
    'magnesium_mg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _omega3GMeta = const VerificationMeta(
    'omega3G',
  );
  @override
  late final GeneratedColumn<double> omega3G = GeneratedColumn<double>(
    'omega3_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _prebioticFiberGMeta = const VerificationMeta(
    'prebioticFiberG',
  );
  @override
  late final GeneratedColumn<double> prebioticFiberG = GeneratedColumn<double>(
    'prebiotic_fiber_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tryptophanMgMeta = const VerificationMeta(
    'tryptophanMg',
  );
  @override
  late final GeneratedColumn<double> tryptophanMg = GeneratedColumn<double>(
    'tryptophan_mg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    mealId,
    userId,
    suggestionId,
    mealName,
    mealSlot,
    plantSpeciesCount,
    plantSpeciesList,
    fermentedServings,
    magnesiumMg,
    omega3G,
    prebioticFiberG,
    tryptophanMg,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Meal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('meal_id')) {
      context.handle(
        _mealIdMeta,
        mealId.isAcceptableOrUnknown(data['meal_id']!, _mealIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mealIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('suggestion_id')) {
      context.handle(
        _suggestionIdMeta,
        suggestionId.isAcceptableOrUnknown(
          data['suggestion_id']!,
          _suggestionIdMeta,
        ),
      );
    }
    if (data.containsKey('meal_name')) {
      context.handle(
        _mealNameMeta,
        mealName.isAcceptableOrUnknown(data['meal_name']!, _mealNameMeta),
      );
    }
    if (data.containsKey('meal_slot')) {
      context.handle(
        _mealSlotMeta,
        mealSlot.isAcceptableOrUnknown(data['meal_slot']!, _mealSlotMeta),
      );
    }
    if (data.containsKey('plant_species_count')) {
      context.handle(
        _plantSpeciesCountMeta,
        plantSpeciesCount.isAcceptableOrUnknown(
          data['plant_species_count']!,
          _plantSpeciesCountMeta,
        ),
      );
    }
    if (data.containsKey('plant_species_list')) {
      context.handle(
        _plantSpeciesListMeta,
        plantSpeciesList.isAcceptableOrUnknown(
          data['plant_species_list']!,
          _plantSpeciesListMeta,
        ),
      );
    }
    if (data.containsKey('fermented_servings')) {
      context.handle(
        _fermentedServingsMeta,
        fermentedServings.isAcceptableOrUnknown(
          data['fermented_servings']!,
          _fermentedServingsMeta,
        ),
      );
    }
    if (data.containsKey('magnesium_mg')) {
      context.handle(
        _magnesiumMgMeta,
        magnesiumMg.isAcceptableOrUnknown(
          data['magnesium_mg']!,
          _magnesiumMgMeta,
        ),
      );
    }
    if (data.containsKey('omega3_g')) {
      context.handle(
        _omega3GMeta,
        omega3G.isAcceptableOrUnknown(data['omega3_g']!, _omega3GMeta),
      );
    }
    if (data.containsKey('prebiotic_fiber_g')) {
      context.handle(
        _prebioticFiberGMeta,
        prebioticFiberG.isAcceptableOrUnknown(
          data['prebiotic_fiber_g']!,
          _prebioticFiberGMeta,
        ),
      );
    }
    if (data.containsKey('tryptophan_mg')) {
      context.handle(
        _tryptophanMgMeta,
        tryptophanMg.isAcceptableOrUnknown(
          data['tryptophan_mg']!,
          _tryptophanMgMeta,
        ),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {mealId};
  @override
  Meal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Meal(
      mealId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      suggestionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}suggestion_id'],
      ),
      mealName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_name'],
      ),
      mealSlot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_slot'],
      ),
      plantSpeciesCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plant_species_count'],
      ),
      plantSpeciesList: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plant_species_list'],
      ),
      fermentedServings: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fermented_servings'],
      ),
      magnesiumMg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}magnesium_mg'],
      ),
      omega3G: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}omega3_g'],
      ),
      prebioticFiberG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}prebiotic_fiber_g'],
      ),
      tryptophanMg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tryptophan_mg'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $MealsTable createAlias(String alias) {
    return $MealsTable(attachedDatabase, alias);
  }
}

class Meal extends DataClass implements Insertable<Meal> {
  final String mealId;
  final String userId;

  /// Nullable FK to meal_suggestions. NULL means user-created with no suggestion.
  final String? suggestionId;
  final String? mealName;
  final String? mealSlot;
  final int? plantSpeciesCount;

  /// JSON-encoded list of plant species names.
  final String? plantSpeciesList;
  final double? fermentedServings;
  final double? magnesiumMg;
  final double? omega3G;
  final double? prebioticFiberG;
  final double? tryptophanMg;

  /// Flag for offline sync. True if successfully synced to the backend.
  final bool isSynced;
  const Meal({
    required this.mealId,
    required this.userId,
    this.suggestionId,
    this.mealName,
    this.mealSlot,
    this.plantSpeciesCount,
    this.plantSpeciesList,
    this.fermentedServings,
    this.magnesiumMg,
    this.omega3G,
    this.prebioticFiberG,
    this.tryptophanMg,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['meal_id'] = Variable<String>(mealId);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || suggestionId != null) {
      map['suggestion_id'] = Variable<String>(suggestionId);
    }
    if (!nullToAbsent || mealName != null) {
      map['meal_name'] = Variable<String>(mealName);
    }
    if (!nullToAbsent || mealSlot != null) {
      map['meal_slot'] = Variable<String>(mealSlot);
    }
    if (!nullToAbsent || plantSpeciesCount != null) {
      map['plant_species_count'] = Variable<int>(plantSpeciesCount);
    }
    if (!nullToAbsent || plantSpeciesList != null) {
      map['plant_species_list'] = Variable<String>(plantSpeciesList);
    }
    if (!nullToAbsent || fermentedServings != null) {
      map['fermented_servings'] = Variable<double>(fermentedServings);
    }
    if (!nullToAbsent || magnesiumMg != null) {
      map['magnesium_mg'] = Variable<double>(magnesiumMg);
    }
    if (!nullToAbsent || omega3G != null) {
      map['omega3_g'] = Variable<double>(omega3G);
    }
    if (!nullToAbsent || prebioticFiberG != null) {
      map['prebiotic_fiber_g'] = Variable<double>(prebioticFiberG);
    }
    if (!nullToAbsent || tryptophanMg != null) {
      map['tryptophan_mg'] = Variable<double>(tryptophanMg);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  MealsCompanion toCompanion(bool nullToAbsent) {
    return MealsCompanion(
      mealId: Value(mealId),
      userId: Value(userId),
      suggestionId: suggestionId == null && nullToAbsent
          ? const Value.absent()
          : Value(suggestionId),
      mealName: mealName == null && nullToAbsent
          ? const Value.absent()
          : Value(mealName),
      mealSlot: mealSlot == null && nullToAbsent
          ? const Value.absent()
          : Value(mealSlot),
      plantSpeciesCount: plantSpeciesCount == null && nullToAbsent
          ? const Value.absent()
          : Value(plantSpeciesCount),
      plantSpeciesList: plantSpeciesList == null && nullToAbsent
          ? const Value.absent()
          : Value(plantSpeciesList),
      fermentedServings: fermentedServings == null && nullToAbsent
          ? const Value.absent()
          : Value(fermentedServings),
      magnesiumMg: magnesiumMg == null && nullToAbsent
          ? const Value.absent()
          : Value(magnesiumMg),
      omega3G: omega3G == null && nullToAbsent
          ? const Value.absent()
          : Value(omega3G),
      prebioticFiberG: prebioticFiberG == null && nullToAbsent
          ? const Value.absent()
          : Value(prebioticFiberG),
      tryptophanMg: tryptophanMg == null && nullToAbsent
          ? const Value.absent()
          : Value(tryptophanMg),
      isSynced: Value(isSynced),
    );
  }

  factory Meal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Meal(
      mealId: serializer.fromJson<String>(json['mealId']),
      userId: serializer.fromJson<String>(json['userId']),
      suggestionId: serializer.fromJson<String?>(json['suggestionId']),
      mealName: serializer.fromJson<String?>(json['mealName']),
      mealSlot: serializer.fromJson<String?>(json['mealSlot']),
      plantSpeciesCount: serializer.fromJson<int?>(json['plantSpeciesCount']),
      plantSpeciesList: serializer.fromJson<String?>(json['plantSpeciesList']),
      fermentedServings: serializer.fromJson<double?>(
        json['fermentedServings'],
      ),
      magnesiumMg: serializer.fromJson<double?>(json['magnesiumMg']),
      omega3G: serializer.fromJson<double?>(json['omega3G']),
      prebioticFiberG: serializer.fromJson<double?>(json['prebioticFiberG']),
      tryptophanMg: serializer.fromJson<double?>(json['tryptophanMg']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mealId': serializer.toJson<String>(mealId),
      'userId': serializer.toJson<String>(userId),
      'suggestionId': serializer.toJson<String?>(suggestionId),
      'mealName': serializer.toJson<String?>(mealName),
      'mealSlot': serializer.toJson<String?>(mealSlot),
      'plantSpeciesCount': serializer.toJson<int?>(plantSpeciesCount),
      'plantSpeciesList': serializer.toJson<String?>(plantSpeciesList),
      'fermentedServings': serializer.toJson<double?>(fermentedServings),
      'magnesiumMg': serializer.toJson<double?>(magnesiumMg),
      'omega3G': serializer.toJson<double?>(omega3G),
      'prebioticFiberG': serializer.toJson<double?>(prebioticFiberG),
      'tryptophanMg': serializer.toJson<double?>(tryptophanMg),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  Meal copyWith({
    String? mealId,
    String? userId,
    Value<String?> suggestionId = const Value.absent(),
    Value<String?> mealName = const Value.absent(),
    Value<String?> mealSlot = const Value.absent(),
    Value<int?> plantSpeciesCount = const Value.absent(),
    Value<String?> plantSpeciesList = const Value.absent(),
    Value<double?> fermentedServings = const Value.absent(),
    Value<double?> magnesiumMg = const Value.absent(),
    Value<double?> omega3G = const Value.absent(),
    Value<double?> prebioticFiberG = const Value.absent(),
    Value<double?> tryptophanMg = const Value.absent(),
    bool? isSynced,
  }) => Meal(
    mealId: mealId ?? this.mealId,
    userId: userId ?? this.userId,
    suggestionId: suggestionId.present ? suggestionId.value : this.suggestionId,
    mealName: mealName.present ? mealName.value : this.mealName,
    mealSlot: mealSlot.present ? mealSlot.value : this.mealSlot,
    plantSpeciesCount: plantSpeciesCount.present
        ? plantSpeciesCount.value
        : this.plantSpeciesCount,
    plantSpeciesList: plantSpeciesList.present
        ? plantSpeciesList.value
        : this.plantSpeciesList,
    fermentedServings: fermentedServings.present
        ? fermentedServings.value
        : this.fermentedServings,
    magnesiumMg: magnesiumMg.present ? magnesiumMg.value : this.magnesiumMg,
    omega3G: omega3G.present ? omega3G.value : this.omega3G,
    prebioticFiberG: prebioticFiberG.present
        ? prebioticFiberG.value
        : this.prebioticFiberG,
    tryptophanMg: tryptophanMg.present ? tryptophanMg.value : this.tryptophanMg,
    isSynced: isSynced ?? this.isSynced,
  );
  Meal copyWithCompanion(MealsCompanion data) {
    return Meal(
      mealId: data.mealId.present ? data.mealId.value : this.mealId,
      userId: data.userId.present ? data.userId.value : this.userId,
      suggestionId: data.suggestionId.present
          ? data.suggestionId.value
          : this.suggestionId,
      mealName: data.mealName.present ? data.mealName.value : this.mealName,
      mealSlot: data.mealSlot.present ? data.mealSlot.value : this.mealSlot,
      plantSpeciesCount: data.plantSpeciesCount.present
          ? data.plantSpeciesCount.value
          : this.plantSpeciesCount,
      plantSpeciesList: data.plantSpeciesList.present
          ? data.plantSpeciesList.value
          : this.plantSpeciesList,
      fermentedServings: data.fermentedServings.present
          ? data.fermentedServings.value
          : this.fermentedServings,
      magnesiumMg: data.magnesiumMg.present
          ? data.magnesiumMg.value
          : this.magnesiumMg,
      omega3G: data.omega3G.present ? data.omega3G.value : this.omega3G,
      prebioticFiberG: data.prebioticFiberG.present
          ? data.prebioticFiberG.value
          : this.prebioticFiberG,
      tryptophanMg: data.tryptophanMg.present
          ? data.tryptophanMg.value
          : this.tryptophanMg,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Meal(')
          ..write('mealId: $mealId, ')
          ..write('userId: $userId, ')
          ..write('suggestionId: $suggestionId, ')
          ..write('mealName: $mealName, ')
          ..write('mealSlot: $mealSlot, ')
          ..write('plantSpeciesCount: $plantSpeciesCount, ')
          ..write('plantSpeciesList: $plantSpeciesList, ')
          ..write('fermentedServings: $fermentedServings, ')
          ..write('magnesiumMg: $magnesiumMg, ')
          ..write('omega3G: $omega3G, ')
          ..write('prebioticFiberG: $prebioticFiberG, ')
          ..write('tryptophanMg: $tryptophanMg, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    mealId,
    userId,
    suggestionId,
    mealName,
    mealSlot,
    plantSpeciesCount,
    plantSpeciesList,
    fermentedServings,
    magnesiumMg,
    omega3G,
    prebioticFiberG,
    tryptophanMg,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Meal &&
          other.mealId == this.mealId &&
          other.userId == this.userId &&
          other.suggestionId == this.suggestionId &&
          other.mealName == this.mealName &&
          other.mealSlot == this.mealSlot &&
          other.plantSpeciesCount == this.plantSpeciesCount &&
          other.plantSpeciesList == this.plantSpeciesList &&
          other.fermentedServings == this.fermentedServings &&
          other.magnesiumMg == this.magnesiumMg &&
          other.omega3G == this.omega3G &&
          other.prebioticFiberG == this.prebioticFiberG &&
          other.tryptophanMg == this.tryptophanMg &&
          other.isSynced == this.isSynced);
}

class MealsCompanion extends UpdateCompanion<Meal> {
  final Value<String> mealId;
  final Value<String> userId;
  final Value<String?> suggestionId;
  final Value<String?> mealName;
  final Value<String?> mealSlot;
  final Value<int?> plantSpeciesCount;
  final Value<String?> plantSpeciesList;
  final Value<double?> fermentedServings;
  final Value<double?> magnesiumMg;
  final Value<double?> omega3G;
  final Value<double?> prebioticFiberG;
  final Value<double?> tryptophanMg;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const MealsCompanion({
    this.mealId = const Value.absent(),
    this.userId = const Value.absent(),
    this.suggestionId = const Value.absent(),
    this.mealName = const Value.absent(),
    this.mealSlot = const Value.absent(),
    this.plantSpeciesCount = const Value.absent(),
    this.plantSpeciesList = const Value.absent(),
    this.fermentedServings = const Value.absent(),
    this.magnesiumMg = const Value.absent(),
    this.omega3G = const Value.absent(),
    this.prebioticFiberG = const Value.absent(),
    this.tryptophanMg = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MealsCompanion.insert({
    required String mealId,
    required String userId,
    this.suggestionId = const Value.absent(),
    this.mealName = const Value.absent(),
    this.mealSlot = const Value.absent(),
    this.plantSpeciesCount = const Value.absent(),
    this.plantSpeciesList = const Value.absent(),
    this.fermentedServings = const Value.absent(),
    this.magnesiumMg = const Value.absent(),
    this.omega3G = const Value.absent(),
    this.prebioticFiberG = const Value.absent(),
    this.tryptophanMg = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : mealId = Value(mealId),
       userId = Value(userId);
  static Insertable<Meal> custom({
    Expression<String>? mealId,
    Expression<String>? userId,
    Expression<String>? suggestionId,
    Expression<String>? mealName,
    Expression<String>? mealSlot,
    Expression<int>? plantSpeciesCount,
    Expression<String>? plantSpeciesList,
    Expression<double>? fermentedServings,
    Expression<double>? magnesiumMg,
    Expression<double>? omega3G,
    Expression<double>? prebioticFiberG,
    Expression<double>? tryptophanMg,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (mealId != null) 'meal_id': mealId,
      if (userId != null) 'user_id': userId,
      if (suggestionId != null) 'suggestion_id': suggestionId,
      if (mealName != null) 'meal_name': mealName,
      if (mealSlot != null) 'meal_slot': mealSlot,
      if (plantSpeciesCount != null) 'plant_species_count': plantSpeciesCount,
      if (plantSpeciesList != null) 'plant_species_list': plantSpeciesList,
      if (fermentedServings != null) 'fermented_servings': fermentedServings,
      if (magnesiumMg != null) 'magnesium_mg': magnesiumMg,
      if (omega3G != null) 'omega3_g': omega3G,
      if (prebioticFiberG != null) 'prebiotic_fiber_g': prebioticFiberG,
      if (tryptophanMg != null) 'tryptophan_mg': tryptophanMg,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MealsCompanion copyWith({
    Value<String>? mealId,
    Value<String>? userId,
    Value<String?>? suggestionId,
    Value<String?>? mealName,
    Value<String?>? mealSlot,
    Value<int?>? plantSpeciesCount,
    Value<String?>? plantSpeciesList,
    Value<double?>? fermentedServings,
    Value<double?>? magnesiumMg,
    Value<double?>? omega3G,
    Value<double?>? prebioticFiberG,
    Value<double?>? tryptophanMg,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return MealsCompanion(
      mealId: mealId ?? this.mealId,
      userId: userId ?? this.userId,
      suggestionId: suggestionId ?? this.suggestionId,
      mealName: mealName ?? this.mealName,
      mealSlot: mealSlot ?? this.mealSlot,
      plantSpeciesCount: plantSpeciesCount ?? this.plantSpeciesCount,
      plantSpeciesList: plantSpeciesList ?? this.plantSpeciesList,
      fermentedServings: fermentedServings ?? this.fermentedServings,
      magnesiumMg: magnesiumMg ?? this.magnesiumMg,
      omega3G: omega3G ?? this.omega3G,
      prebioticFiberG: prebioticFiberG ?? this.prebioticFiberG,
      tryptophanMg: tryptophanMg ?? this.tryptophanMg,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mealId.present) {
      map['meal_id'] = Variable<String>(mealId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (suggestionId.present) {
      map['suggestion_id'] = Variable<String>(suggestionId.value);
    }
    if (mealName.present) {
      map['meal_name'] = Variable<String>(mealName.value);
    }
    if (mealSlot.present) {
      map['meal_slot'] = Variable<String>(mealSlot.value);
    }
    if (plantSpeciesCount.present) {
      map['plant_species_count'] = Variable<int>(plantSpeciesCount.value);
    }
    if (plantSpeciesList.present) {
      map['plant_species_list'] = Variable<String>(plantSpeciesList.value);
    }
    if (fermentedServings.present) {
      map['fermented_servings'] = Variable<double>(fermentedServings.value);
    }
    if (magnesiumMg.present) {
      map['magnesium_mg'] = Variable<double>(magnesiumMg.value);
    }
    if (omega3G.present) {
      map['omega3_g'] = Variable<double>(omega3G.value);
    }
    if (prebioticFiberG.present) {
      map['prebiotic_fiber_g'] = Variable<double>(prebioticFiberG.value);
    }
    if (tryptophanMg.present) {
      map['tryptophan_mg'] = Variable<double>(tryptophanMg.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealsCompanion(')
          ..write('mealId: $mealId, ')
          ..write('userId: $userId, ')
          ..write('suggestionId: $suggestionId, ')
          ..write('mealName: $mealName, ')
          ..write('mealSlot: $mealSlot, ')
          ..write('plantSpeciesCount: $plantSpeciesCount, ')
          ..write('plantSpeciesList: $plantSpeciesList, ')
          ..write('fermentedServings: $fermentedServings, ')
          ..write('magnesiumMg: $magnesiumMg, ')
          ..write('omega3G: $omega3G, ')
          ..write('prebioticFiberG: $prebioticFiberG, ')
          ..write('tryptophanMg: $tryptophanMg, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MealLogsTable extends MealLogs with TableInfo<$MealLogsTable, MealLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _logIdMeta = const VerificationMeta('logId');
  @override
  late final GeneratedColumn<String> logId = GeneratedColumn<String>(
    'log_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealIdMeta = const VerificationMeta('mealId');
  @override
  late final GeneratedColumn<String> mealId = GeneratedColumn<String>(
    'meal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meals (meal_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealSlotMeta = const VerificationMeta(
    'mealSlot',
  );
  @override
  late final GeneratedColumn<String> mealSlot = GeneratedColumn<String>(
    'meal_slot',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<String> loggedAt = GeneratedColumn<String>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    logId,
    mealId,
    userId,
    date,
    mealSlot,
    loggedAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('log_id')) {
      context.handle(
        _logIdMeta,
        logId.isAcceptableOrUnknown(data['log_id']!, _logIdMeta),
      );
    } else if (isInserting) {
      context.missing(_logIdMeta);
    }
    if (data.containsKey('meal_id')) {
      context.handle(
        _mealIdMeta,
        mealId.isAcceptableOrUnknown(data['meal_id']!, _mealIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mealIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('meal_slot')) {
      context.handle(
        _mealSlotMeta,
        mealSlot.isAcceptableOrUnknown(data['meal_slot']!, _mealSlotMeta),
      );
    } else if (isInserting) {
      context.missing(_mealSlotMeta);
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {logId};
  @override
  MealLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealLog(
      logId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}log_id'],
      )!,
      mealId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      mealSlot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_slot'],
      )!,
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logged_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $MealLogsTable createAlias(String alias) {
    return $MealLogsTable(attachedDatabase, alias);
  }
}

class MealLog extends DataClass implements Insertable<MealLog> {
  final String logId;

  /// FK → meals.meal_id with ON DELETE CASCADE.
  final String mealId;
  final String userId;
  final String date;
  final String mealSlot;
  final String loggedAt;

  /// Flag for offline sync. True if successfully synced to the backend.
  final bool isSynced;
  const MealLog({
    required this.logId,
    required this.mealId,
    required this.userId,
    required this.date,
    required this.mealSlot,
    required this.loggedAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['log_id'] = Variable<String>(logId);
    map['meal_id'] = Variable<String>(mealId);
    map['user_id'] = Variable<String>(userId);
    map['date'] = Variable<String>(date);
    map['meal_slot'] = Variable<String>(mealSlot);
    map['logged_at'] = Variable<String>(loggedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  MealLogsCompanion toCompanion(bool nullToAbsent) {
    return MealLogsCompanion(
      logId: Value(logId),
      mealId: Value(mealId),
      userId: Value(userId),
      date: Value(date),
      mealSlot: Value(mealSlot),
      loggedAt: Value(loggedAt),
      isSynced: Value(isSynced),
    );
  }

  factory MealLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealLog(
      logId: serializer.fromJson<String>(json['logId']),
      mealId: serializer.fromJson<String>(json['mealId']),
      userId: serializer.fromJson<String>(json['userId']),
      date: serializer.fromJson<String>(json['date']),
      mealSlot: serializer.fromJson<String>(json['mealSlot']),
      loggedAt: serializer.fromJson<String>(json['loggedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'logId': serializer.toJson<String>(logId),
      'mealId': serializer.toJson<String>(mealId),
      'userId': serializer.toJson<String>(userId),
      'date': serializer.toJson<String>(date),
      'mealSlot': serializer.toJson<String>(mealSlot),
      'loggedAt': serializer.toJson<String>(loggedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  MealLog copyWith({
    String? logId,
    String? mealId,
    String? userId,
    String? date,
    String? mealSlot,
    String? loggedAt,
    bool? isSynced,
  }) => MealLog(
    logId: logId ?? this.logId,
    mealId: mealId ?? this.mealId,
    userId: userId ?? this.userId,
    date: date ?? this.date,
    mealSlot: mealSlot ?? this.mealSlot,
    loggedAt: loggedAt ?? this.loggedAt,
    isSynced: isSynced ?? this.isSynced,
  );
  MealLog copyWithCompanion(MealLogsCompanion data) {
    return MealLog(
      logId: data.logId.present ? data.logId.value : this.logId,
      mealId: data.mealId.present ? data.mealId.value : this.mealId,
      userId: data.userId.present ? data.userId.value : this.userId,
      date: data.date.present ? data.date.value : this.date,
      mealSlot: data.mealSlot.present ? data.mealSlot.value : this.mealSlot,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealLog(')
          ..write('logId: $logId, ')
          ..write('mealId: $mealId, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('mealSlot: $mealSlot, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(logId, mealId, userId, date, mealSlot, loggedAt, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealLog &&
          other.logId == this.logId &&
          other.mealId == this.mealId &&
          other.userId == this.userId &&
          other.date == this.date &&
          other.mealSlot == this.mealSlot &&
          other.loggedAt == this.loggedAt &&
          other.isSynced == this.isSynced);
}

class MealLogsCompanion extends UpdateCompanion<MealLog> {
  final Value<String> logId;
  final Value<String> mealId;
  final Value<String> userId;
  final Value<String> date;
  final Value<String> mealSlot;
  final Value<String> loggedAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const MealLogsCompanion({
    this.logId = const Value.absent(),
    this.mealId = const Value.absent(),
    this.userId = const Value.absent(),
    this.date = const Value.absent(),
    this.mealSlot = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MealLogsCompanion.insert({
    required String logId,
    required String mealId,
    required String userId,
    required String date,
    required String mealSlot,
    required String loggedAt,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : logId = Value(logId),
       mealId = Value(mealId),
       userId = Value(userId),
       date = Value(date),
       mealSlot = Value(mealSlot),
       loggedAt = Value(loggedAt);
  static Insertable<MealLog> custom({
    Expression<String>? logId,
    Expression<String>? mealId,
    Expression<String>? userId,
    Expression<String>? date,
    Expression<String>? mealSlot,
    Expression<String>? loggedAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (logId != null) 'log_id': logId,
      if (mealId != null) 'meal_id': mealId,
      if (userId != null) 'user_id': userId,
      if (date != null) 'date': date,
      if (mealSlot != null) 'meal_slot': mealSlot,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MealLogsCompanion copyWith({
    Value<String>? logId,
    Value<String>? mealId,
    Value<String>? userId,
    Value<String>? date,
    Value<String>? mealSlot,
    Value<String>? loggedAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return MealLogsCompanion(
      logId: logId ?? this.logId,
      mealId: mealId ?? this.mealId,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      mealSlot: mealSlot ?? this.mealSlot,
      loggedAt: loggedAt ?? this.loggedAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (logId.present) {
      map['log_id'] = Variable<String>(logId.value);
    }
    if (mealId.present) {
      map['meal_id'] = Variable<String>(mealId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (mealSlot.present) {
      map['meal_slot'] = Variable<String>(mealSlot.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<String>(loggedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealLogsCompanion(')
          ..write('logId: $logId, ')
          ..write('mealId: $mealId, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('mealSlot: $mealSlot, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyNutrientTotalsTable extends DailyNutrientTotals
    with TableInfo<$DailyNutrientTotalsTable, DailyNutrientTotal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyNutrientTotalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _totalIdMeta = const VerificationMeta(
    'totalId',
  );
  @override
  late final GeneratedColumn<String> totalId = GeneratedColumn<String>(
    'total_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _computedAtMeta = const VerificationMeta(
    'computedAt',
  );
  @override
  late final GeneratedColumn<String> computedAt = GeneratedColumn<String>(
    'computed_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fermentedServingsMeta = const VerificationMeta(
    'fermentedServings',
  );
  @override
  late final GeneratedColumn<double> fermentedServings =
      GeneratedColumn<double>(
        'fermented_servings',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _magnesiumMgMeta = const VerificationMeta(
    'magnesiumMg',
  );
  @override
  late final GeneratedColumn<double> magnesiumMg = GeneratedColumn<double>(
    'magnesium_mg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _omega3GMeta = const VerificationMeta(
    'omega3G',
  );
  @override
  late final GeneratedColumn<double> omega3G = GeneratedColumn<double>(
    'omega3_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _overallScorePctMeta = const VerificationMeta(
    'overallScorePct',
  );
  @override
  late final GeneratedColumn<double> overallScorePct = GeneratedColumn<double>(
    'overall_score_pct',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _plantSpeciesCountMeta = const VerificationMeta(
    'plantSpeciesCount',
  );
  @override
  late final GeneratedColumn<int> plantSpeciesCount = GeneratedColumn<int>(
    'plant_species_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _prebioticFiberGMeta = const VerificationMeta(
    'prebioticFiberG',
  );
  @override
  late final GeneratedColumn<double> prebioticFiberG = GeneratedColumn<double>(
    'prebiotic_fiber_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tryptophanMgMeta = const VerificationMeta(
    'tryptophanMg',
  );
  @override
  late final GeneratedColumn<double> tryptophanMg = GeneratedColumn<double>(
    'tryptophan_mg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetFermentedMeta = const VerificationMeta(
    'targetFermented',
  );
  @override
  late final GeneratedColumn<double> targetFermented = GeneratedColumn<double>(
    'target_fermented',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetFiberGMeta = const VerificationMeta(
    'targetFiberG',
  );
  @override
  late final GeneratedColumn<double> targetFiberG = GeneratedColumn<double>(
    'target_fiber_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetMagnesiumMgMeta = const VerificationMeta(
    'targetMagnesiumMg',
  );
  @override
  late final GeneratedColumn<double> targetMagnesiumMg =
      GeneratedColumn<double>(
        'target_magnesium_mg',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _targetOmega3GMeta = const VerificationMeta(
    'targetOmega3G',
  );
  @override
  late final GeneratedColumn<double> targetOmega3G = GeneratedColumn<double>(
    'target_omega3_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetPlantSpeciesMeta =
      const VerificationMeta('targetPlantSpecies');
  @override
  late final GeneratedColumn<int> targetPlantSpecies = GeneratedColumn<int>(
    'target_plant_species',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetTryptophanMgMeta =
      const VerificationMeta('targetTryptophanMg');
  @override
  late final GeneratedColumn<double> targetTryptophanMg =
      GeneratedColumn<double>(
        'target_tryptophan_mg',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    totalId,
    userId,
    date,
    computedAt,
    fermentedServings,
    magnesiumMg,
    omega3G,
    overallScorePct,
    plantSpeciesCount,
    prebioticFiberG,
    tryptophanMg,
    targetFermented,
    targetFiberG,
    targetMagnesiumMg,
    targetOmega3G,
    targetPlantSpecies,
    targetTryptophanMg,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_nutrient_totals';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyNutrientTotal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('total_id')) {
      context.handle(
        _totalIdMeta,
        totalId.isAcceptableOrUnknown(data['total_id']!, _totalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_totalIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('computed_at')) {
      context.handle(
        _computedAtMeta,
        computedAt.isAcceptableOrUnknown(data['computed_at']!, _computedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_computedAtMeta);
    }
    if (data.containsKey('fermented_servings')) {
      context.handle(
        _fermentedServingsMeta,
        fermentedServings.isAcceptableOrUnknown(
          data['fermented_servings']!,
          _fermentedServingsMeta,
        ),
      );
    }
    if (data.containsKey('magnesium_mg')) {
      context.handle(
        _magnesiumMgMeta,
        magnesiumMg.isAcceptableOrUnknown(
          data['magnesium_mg']!,
          _magnesiumMgMeta,
        ),
      );
    }
    if (data.containsKey('omega3_g')) {
      context.handle(
        _omega3GMeta,
        omega3G.isAcceptableOrUnknown(data['omega3_g']!, _omega3GMeta),
      );
    }
    if (data.containsKey('overall_score_pct')) {
      context.handle(
        _overallScorePctMeta,
        overallScorePct.isAcceptableOrUnknown(
          data['overall_score_pct']!,
          _overallScorePctMeta,
        ),
      );
    }
    if (data.containsKey('plant_species_count')) {
      context.handle(
        _plantSpeciesCountMeta,
        plantSpeciesCount.isAcceptableOrUnknown(
          data['plant_species_count']!,
          _plantSpeciesCountMeta,
        ),
      );
    }
    if (data.containsKey('prebiotic_fiber_g')) {
      context.handle(
        _prebioticFiberGMeta,
        prebioticFiberG.isAcceptableOrUnknown(
          data['prebiotic_fiber_g']!,
          _prebioticFiberGMeta,
        ),
      );
    }
    if (data.containsKey('tryptophan_mg')) {
      context.handle(
        _tryptophanMgMeta,
        tryptophanMg.isAcceptableOrUnknown(
          data['tryptophan_mg']!,
          _tryptophanMgMeta,
        ),
      );
    }
    if (data.containsKey('target_fermented')) {
      context.handle(
        _targetFermentedMeta,
        targetFermented.isAcceptableOrUnknown(
          data['target_fermented']!,
          _targetFermentedMeta,
        ),
      );
    }
    if (data.containsKey('target_fiber_g')) {
      context.handle(
        _targetFiberGMeta,
        targetFiberG.isAcceptableOrUnknown(
          data['target_fiber_g']!,
          _targetFiberGMeta,
        ),
      );
    }
    if (data.containsKey('target_magnesium_mg')) {
      context.handle(
        _targetMagnesiumMgMeta,
        targetMagnesiumMg.isAcceptableOrUnknown(
          data['target_magnesium_mg']!,
          _targetMagnesiumMgMeta,
        ),
      );
    }
    if (data.containsKey('target_omega3_g')) {
      context.handle(
        _targetOmega3GMeta,
        targetOmega3G.isAcceptableOrUnknown(
          data['target_omega3_g']!,
          _targetOmega3GMeta,
        ),
      );
    }
    if (data.containsKey('target_plant_species')) {
      context.handle(
        _targetPlantSpeciesMeta,
        targetPlantSpecies.isAcceptableOrUnknown(
          data['target_plant_species']!,
          _targetPlantSpeciesMeta,
        ),
      );
    }
    if (data.containsKey('target_tryptophan_mg')) {
      context.handle(
        _targetTryptophanMgMeta,
        targetTryptophanMg.isAcceptableOrUnknown(
          data['target_tryptophan_mg']!,
          _targetTryptophanMgMeta,
        ),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {totalId};
  @override
  DailyNutrientTotal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyNutrientTotal(
      totalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}total_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      computedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}computed_at'],
      )!,
      fermentedServings: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fermented_servings'],
      ),
      magnesiumMg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}magnesium_mg'],
      ),
      omega3G: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}omega3_g'],
      ),
      overallScorePct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}overall_score_pct'],
      ),
      plantSpeciesCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plant_species_count'],
      ),
      prebioticFiberG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}prebiotic_fiber_g'],
      ),
      tryptophanMg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tryptophan_mg'],
      ),
      targetFermented: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_fermented'],
      ),
      targetFiberG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_fiber_g'],
      ),
      targetMagnesiumMg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_magnesium_mg'],
      ),
      targetOmega3G: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_omega3_g'],
      ),
      targetPlantSpecies: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_plant_species'],
      ),
      targetTryptophanMg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_tryptophan_mg'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $DailyNutrientTotalsTable createAlias(String alias) {
    return $DailyNutrientTotalsTable(attachedDatabase, alias);
  }
}

class DailyNutrientTotal extends DataClass
    implements Insertable<DailyNutrientTotal> {
  final String totalId;
  final String userId;
  final String date;
  final String computedAt;
  final double? fermentedServings;
  final double? magnesiumMg;
  final double? omega3G;
  final double? overallScorePct;
  final int? plantSpeciesCount;
  final double? prebioticFiberG;
  final double? tryptophanMg;
  final double? targetFermented;
  final double? targetFiberG;
  final double? targetMagnesiumMg;
  final double? targetOmega3G;
  final int? targetPlantSpecies;
  final double? targetTryptophanMg;

  /// Flag for offline sync. True if successfully synced to the backend.
  final bool isSynced;
  const DailyNutrientTotal({
    required this.totalId,
    required this.userId,
    required this.date,
    required this.computedAt,
    this.fermentedServings,
    this.magnesiumMg,
    this.omega3G,
    this.overallScorePct,
    this.plantSpeciesCount,
    this.prebioticFiberG,
    this.tryptophanMg,
    this.targetFermented,
    this.targetFiberG,
    this.targetMagnesiumMg,
    this.targetOmega3G,
    this.targetPlantSpecies,
    this.targetTryptophanMg,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['total_id'] = Variable<String>(totalId);
    map['user_id'] = Variable<String>(userId);
    map['date'] = Variable<String>(date);
    map['computed_at'] = Variable<String>(computedAt);
    if (!nullToAbsent || fermentedServings != null) {
      map['fermented_servings'] = Variable<double>(fermentedServings);
    }
    if (!nullToAbsent || magnesiumMg != null) {
      map['magnesium_mg'] = Variable<double>(magnesiumMg);
    }
    if (!nullToAbsent || omega3G != null) {
      map['omega3_g'] = Variable<double>(omega3G);
    }
    if (!nullToAbsent || overallScorePct != null) {
      map['overall_score_pct'] = Variable<double>(overallScorePct);
    }
    if (!nullToAbsent || plantSpeciesCount != null) {
      map['plant_species_count'] = Variable<int>(plantSpeciesCount);
    }
    if (!nullToAbsent || prebioticFiberG != null) {
      map['prebiotic_fiber_g'] = Variable<double>(prebioticFiberG);
    }
    if (!nullToAbsent || tryptophanMg != null) {
      map['tryptophan_mg'] = Variable<double>(tryptophanMg);
    }
    if (!nullToAbsent || targetFermented != null) {
      map['target_fermented'] = Variable<double>(targetFermented);
    }
    if (!nullToAbsent || targetFiberG != null) {
      map['target_fiber_g'] = Variable<double>(targetFiberG);
    }
    if (!nullToAbsent || targetMagnesiumMg != null) {
      map['target_magnesium_mg'] = Variable<double>(targetMagnesiumMg);
    }
    if (!nullToAbsent || targetOmega3G != null) {
      map['target_omega3_g'] = Variable<double>(targetOmega3G);
    }
    if (!nullToAbsent || targetPlantSpecies != null) {
      map['target_plant_species'] = Variable<int>(targetPlantSpecies);
    }
    if (!nullToAbsent || targetTryptophanMg != null) {
      map['target_tryptophan_mg'] = Variable<double>(targetTryptophanMg);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  DailyNutrientTotalsCompanion toCompanion(bool nullToAbsent) {
    return DailyNutrientTotalsCompanion(
      totalId: Value(totalId),
      userId: Value(userId),
      date: Value(date),
      computedAt: Value(computedAt),
      fermentedServings: fermentedServings == null && nullToAbsent
          ? const Value.absent()
          : Value(fermentedServings),
      magnesiumMg: magnesiumMg == null && nullToAbsent
          ? const Value.absent()
          : Value(magnesiumMg),
      omega3G: omega3G == null && nullToAbsent
          ? const Value.absent()
          : Value(omega3G),
      overallScorePct: overallScorePct == null && nullToAbsent
          ? const Value.absent()
          : Value(overallScorePct),
      plantSpeciesCount: plantSpeciesCount == null && nullToAbsent
          ? const Value.absent()
          : Value(plantSpeciesCount),
      prebioticFiberG: prebioticFiberG == null && nullToAbsent
          ? const Value.absent()
          : Value(prebioticFiberG),
      tryptophanMg: tryptophanMg == null && nullToAbsent
          ? const Value.absent()
          : Value(tryptophanMg),
      targetFermented: targetFermented == null && nullToAbsent
          ? const Value.absent()
          : Value(targetFermented),
      targetFiberG: targetFiberG == null && nullToAbsent
          ? const Value.absent()
          : Value(targetFiberG),
      targetMagnesiumMg: targetMagnesiumMg == null && nullToAbsent
          ? const Value.absent()
          : Value(targetMagnesiumMg),
      targetOmega3G: targetOmega3G == null && nullToAbsent
          ? const Value.absent()
          : Value(targetOmega3G),
      targetPlantSpecies: targetPlantSpecies == null && nullToAbsent
          ? const Value.absent()
          : Value(targetPlantSpecies),
      targetTryptophanMg: targetTryptophanMg == null && nullToAbsent
          ? const Value.absent()
          : Value(targetTryptophanMg),
      isSynced: Value(isSynced),
    );
  }

  factory DailyNutrientTotal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyNutrientTotal(
      totalId: serializer.fromJson<String>(json['totalId']),
      userId: serializer.fromJson<String>(json['userId']),
      date: serializer.fromJson<String>(json['date']),
      computedAt: serializer.fromJson<String>(json['computedAt']),
      fermentedServings: serializer.fromJson<double?>(
        json['fermentedServings'],
      ),
      magnesiumMg: serializer.fromJson<double?>(json['magnesiumMg']),
      omega3G: serializer.fromJson<double?>(json['omega3G']),
      overallScorePct: serializer.fromJson<double?>(json['overallScorePct']),
      plantSpeciesCount: serializer.fromJson<int?>(json['plantSpeciesCount']),
      prebioticFiberG: serializer.fromJson<double?>(json['prebioticFiberG']),
      tryptophanMg: serializer.fromJson<double?>(json['tryptophanMg']),
      targetFermented: serializer.fromJson<double?>(json['targetFermented']),
      targetFiberG: serializer.fromJson<double?>(json['targetFiberG']),
      targetMagnesiumMg: serializer.fromJson<double?>(
        json['targetMagnesiumMg'],
      ),
      targetOmega3G: serializer.fromJson<double?>(json['targetOmega3G']),
      targetPlantSpecies: serializer.fromJson<int?>(json['targetPlantSpecies']),
      targetTryptophanMg: serializer.fromJson<double?>(
        json['targetTryptophanMg'],
      ),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'totalId': serializer.toJson<String>(totalId),
      'userId': serializer.toJson<String>(userId),
      'date': serializer.toJson<String>(date),
      'computedAt': serializer.toJson<String>(computedAt),
      'fermentedServings': serializer.toJson<double?>(fermentedServings),
      'magnesiumMg': serializer.toJson<double?>(magnesiumMg),
      'omega3G': serializer.toJson<double?>(omega3G),
      'overallScorePct': serializer.toJson<double?>(overallScorePct),
      'plantSpeciesCount': serializer.toJson<int?>(plantSpeciesCount),
      'prebioticFiberG': serializer.toJson<double?>(prebioticFiberG),
      'tryptophanMg': serializer.toJson<double?>(tryptophanMg),
      'targetFermented': serializer.toJson<double?>(targetFermented),
      'targetFiberG': serializer.toJson<double?>(targetFiberG),
      'targetMagnesiumMg': serializer.toJson<double?>(targetMagnesiumMg),
      'targetOmega3G': serializer.toJson<double?>(targetOmega3G),
      'targetPlantSpecies': serializer.toJson<int?>(targetPlantSpecies),
      'targetTryptophanMg': serializer.toJson<double?>(targetTryptophanMg),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  DailyNutrientTotal copyWith({
    String? totalId,
    String? userId,
    String? date,
    String? computedAt,
    Value<double?> fermentedServings = const Value.absent(),
    Value<double?> magnesiumMg = const Value.absent(),
    Value<double?> omega3G = const Value.absent(),
    Value<double?> overallScorePct = const Value.absent(),
    Value<int?> plantSpeciesCount = const Value.absent(),
    Value<double?> prebioticFiberG = const Value.absent(),
    Value<double?> tryptophanMg = const Value.absent(),
    Value<double?> targetFermented = const Value.absent(),
    Value<double?> targetFiberG = const Value.absent(),
    Value<double?> targetMagnesiumMg = const Value.absent(),
    Value<double?> targetOmega3G = const Value.absent(),
    Value<int?> targetPlantSpecies = const Value.absent(),
    Value<double?> targetTryptophanMg = const Value.absent(),
    bool? isSynced,
  }) => DailyNutrientTotal(
    totalId: totalId ?? this.totalId,
    userId: userId ?? this.userId,
    date: date ?? this.date,
    computedAt: computedAt ?? this.computedAt,
    fermentedServings: fermentedServings.present
        ? fermentedServings.value
        : this.fermentedServings,
    magnesiumMg: magnesiumMg.present ? magnesiumMg.value : this.magnesiumMg,
    omega3G: omega3G.present ? omega3G.value : this.omega3G,
    overallScorePct: overallScorePct.present
        ? overallScorePct.value
        : this.overallScorePct,
    plantSpeciesCount: plantSpeciesCount.present
        ? plantSpeciesCount.value
        : this.plantSpeciesCount,
    prebioticFiberG: prebioticFiberG.present
        ? prebioticFiberG.value
        : this.prebioticFiberG,
    tryptophanMg: tryptophanMg.present ? tryptophanMg.value : this.tryptophanMg,
    targetFermented: targetFermented.present
        ? targetFermented.value
        : this.targetFermented,
    targetFiberG: targetFiberG.present ? targetFiberG.value : this.targetFiberG,
    targetMagnesiumMg: targetMagnesiumMg.present
        ? targetMagnesiumMg.value
        : this.targetMagnesiumMg,
    targetOmega3G: targetOmega3G.present
        ? targetOmega3G.value
        : this.targetOmega3G,
    targetPlantSpecies: targetPlantSpecies.present
        ? targetPlantSpecies.value
        : this.targetPlantSpecies,
    targetTryptophanMg: targetTryptophanMg.present
        ? targetTryptophanMg.value
        : this.targetTryptophanMg,
    isSynced: isSynced ?? this.isSynced,
  );
  DailyNutrientTotal copyWithCompanion(DailyNutrientTotalsCompanion data) {
    return DailyNutrientTotal(
      totalId: data.totalId.present ? data.totalId.value : this.totalId,
      userId: data.userId.present ? data.userId.value : this.userId,
      date: data.date.present ? data.date.value : this.date,
      computedAt: data.computedAt.present
          ? data.computedAt.value
          : this.computedAt,
      fermentedServings: data.fermentedServings.present
          ? data.fermentedServings.value
          : this.fermentedServings,
      magnesiumMg: data.magnesiumMg.present
          ? data.magnesiumMg.value
          : this.magnesiumMg,
      omega3G: data.omega3G.present ? data.omega3G.value : this.omega3G,
      overallScorePct: data.overallScorePct.present
          ? data.overallScorePct.value
          : this.overallScorePct,
      plantSpeciesCount: data.plantSpeciesCount.present
          ? data.plantSpeciesCount.value
          : this.plantSpeciesCount,
      prebioticFiberG: data.prebioticFiberG.present
          ? data.prebioticFiberG.value
          : this.prebioticFiberG,
      tryptophanMg: data.tryptophanMg.present
          ? data.tryptophanMg.value
          : this.tryptophanMg,
      targetFermented: data.targetFermented.present
          ? data.targetFermented.value
          : this.targetFermented,
      targetFiberG: data.targetFiberG.present
          ? data.targetFiberG.value
          : this.targetFiberG,
      targetMagnesiumMg: data.targetMagnesiumMg.present
          ? data.targetMagnesiumMg.value
          : this.targetMagnesiumMg,
      targetOmega3G: data.targetOmega3G.present
          ? data.targetOmega3G.value
          : this.targetOmega3G,
      targetPlantSpecies: data.targetPlantSpecies.present
          ? data.targetPlantSpecies.value
          : this.targetPlantSpecies,
      targetTryptophanMg: data.targetTryptophanMg.present
          ? data.targetTryptophanMg.value
          : this.targetTryptophanMg,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyNutrientTotal(')
          ..write('totalId: $totalId, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('computedAt: $computedAt, ')
          ..write('fermentedServings: $fermentedServings, ')
          ..write('magnesiumMg: $magnesiumMg, ')
          ..write('omega3G: $omega3G, ')
          ..write('overallScorePct: $overallScorePct, ')
          ..write('plantSpeciesCount: $plantSpeciesCount, ')
          ..write('prebioticFiberG: $prebioticFiberG, ')
          ..write('tryptophanMg: $tryptophanMg, ')
          ..write('targetFermented: $targetFermented, ')
          ..write('targetFiberG: $targetFiberG, ')
          ..write('targetMagnesiumMg: $targetMagnesiumMg, ')
          ..write('targetOmega3G: $targetOmega3G, ')
          ..write('targetPlantSpecies: $targetPlantSpecies, ')
          ..write('targetTryptophanMg: $targetTryptophanMg, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    totalId,
    userId,
    date,
    computedAt,
    fermentedServings,
    magnesiumMg,
    omega3G,
    overallScorePct,
    plantSpeciesCount,
    prebioticFiberG,
    tryptophanMg,
    targetFermented,
    targetFiberG,
    targetMagnesiumMg,
    targetOmega3G,
    targetPlantSpecies,
    targetTryptophanMg,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyNutrientTotal &&
          other.totalId == this.totalId &&
          other.userId == this.userId &&
          other.date == this.date &&
          other.computedAt == this.computedAt &&
          other.fermentedServings == this.fermentedServings &&
          other.magnesiumMg == this.magnesiumMg &&
          other.omega3G == this.omega3G &&
          other.overallScorePct == this.overallScorePct &&
          other.plantSpeciesCount == this.plantSpeciesCount &&
          other.prebioticFiberG == this.prebioticFiberG &&
          other.tryptophanMg == this.tryptophanMg &&
          other.targetFermented == this.targetFermented &&
          other.targetFiberG == this.targetFiberG &&
          other.targetMagnesiumMg == this.targetMagnesiumMg &&
          other.targetOmega3G == this.targetOmega3G &&
          other.targetPlantSpecies == this.targetPlantSpecies &&
          other.targetTryptophanMg == this.targetTryptophanMg &&
          other.isSynced == this.isSynced);
}

class DailyNutrientTotalsCompanion extends UpdateCompanion<DailyNutrientTotal> {
  final Value<String> totalId;
  final Value<String> userId;
  final Value<String> date;
  final Value<String> computedAt;
  final Value<double?> fermentedServings;
  final Value<double?> magnesiumMg;
  final Value<double?> omega3G;
  final Value<double?> overallScorePct;
  final Value<int?> plantSpeciesCount;
  final Value<double?> prebioticFiberG;
  final Value<double?> tryptophanMg;
  final Value<double?> targetFermented;
  final Value<double?> targetFiberG;
  final Value<double?> targetMagnesiumMg;
  final Value<double?> targetOmega3G;
  final Value<int?> targetPlantSpecies;
  final Value<double?> targetTryptophanMg;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const DailyNutrientTotalsCompanion({
    this.totalId = const Value.absent(),
    this.userId = const Value.absent(),
    this.date = const Value.absent(),
    this.computedAt = const Value.absent(),
    this.fermentedServings = const Value.absent(),
    this.magnesiumMg = const Value.absent(),
    this.omega3G = const Value.absent(),
    this.overallScorePct = const Value.absent(),
    this.plantSpeciesCount = const Value.absent(),
    this.prebioticFiberG = const Value.absent(),
    this.tryptophanMg = const Value.absent(),
    this.targetFermented = const Value.absent(),
    this.targetFiberG = const Value.absent(),
    this.targetMagnesiumMg = const Value.absent(),
    this.targetOmega3G = const Value.absent(),
    this.targetPlantSpecies = const Value.absent(),
    this.targetTryptophanMg = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyNutrientTotalsCompanion.insert({
    required String totalId,
    required String userId,
    required String date,
    required String computedAt,
    this.fermentedServings = const Value.absent(),
    this.magnesiumMg = const Value.absent(),
    this.omega3G = const Value.absent(),
    this.overallScorePct = const Value.absent(),
    this.plantSpeciesCount = const Value.absent(),
    this.prebioticFiberG = const Value.absent(),
    this.tryptophanMg = const Value.absent(),
    this.targetFermented = const Value.absent(),
    this.targetFiberG = const Value.absent(),
    this.targetMagnesiumMg = const Value.absent(),
    this.targetOmega3G = const Value.absent(),
    this.targetPlantSpecies = const Value.absent(),
    this.targetTryptophanMg = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : totalId = Value(totalId),
       userId = Value(userId),
       date = Value(date),
       computedAt = Value(computedAt);
  static Insertable<DailyNutrientTotal> custom({
    Expression<String>? totalId,
    Expression<String>? userId,
    Expression<String>? date,
    Expression<String>? computedAt,
    Expression<double>? fermentedServings,
    Expression<double>? magnesiumMg,
    Expression<double>? omega3G,
    Expression<double>? overallScorePct,
    Expression<int>? plantSpeciesCount,
    Expression<double>? prebioticFiberG,
    Expression<double>? tryptophanMg,
    Expression<double>? targetFermented,
    Expression<double>? targetFiberG,
    Expression<double>? targetMagnesiumMg,
    Expression<double>? targetOmega3G,
    Expression<int>? targetPlantSpecies,
    Expression<double>? targetTryptophanMg,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (totalId != null) 'total_id': totalId,
      if (userId != null) 'user_id': userId,
      if (date != null) 'date': date,
      if (computedAt != null) 'computed_at': computedAt,
      if (fermentedServings != null) 'fermented_servings': fermentedServings,
      if (magnesiumMg != null) 'magnesium_mg': magnesiumMg,
      if (omega3G != null) 'omega3_g': omega3G,
      if (overallScorePct != null) 'overall_score_pct': overallScorePct,
      if (plantSpeciesCount != null) 'plant_species_count': plantSpeciesCount,
      if (prebioticFiberG != null) 'prebiotic_fiber_g': prebioticFiberG,
      if (tryptophanMg != null) 'tryptophan_mg': tryptophanMg,
      if (targetFermented != null) 'target_fermented': targetFermented,
      if (targetFiberG != null) 'target_fiber_g': targetFiberG,
      if (targetMagnesiumMg != null) 'target_magnesium_mg': targetMagnesiumMg,
      if (targetOmega3G != null) 'target_omega3_g': targetOmega3G,
      if (targetPlantSpecies != null)
        'target_plant_species': targetPlantSpecies,
      if (targetTryptophanMg != null)
        'target_tryptophan_mg': targetTryptophanMg,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyNutrientTotalsCompanion copyWith({
    Value<String>? totalId,
    Value<String>? userId,
    Value<String>? date,
    Value<String>? computedAt,
    Value<double?>? fermentedServings,
    Value<double?>? magnesiumMg,
    Value<double?>? omega3G,
    Value<double?>? overallScorePct,
    Value<int?>? plantSpeciesCount,
    Value<double?>? prebioticFiberG,
    Value<double?>? tryptophanMg,
    Value<double?>? targetFermented,
    Value<double?>? targetFiberG,
    Value<double?>? targetMagnesiumMg,
    Value<double?>? targetOmega3G,
    Value<int?>? targetPlantSpecies,
    Value<double?>? targetTryptophanMg,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return DailyNutrientTotalsCompanion(
      totalId: totalId ?? this.totalId,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      computedAt: computedAt ?? this.computedAt,
      fermentedServings: fermentedServings ?? this.fermentedServings,
      magnesiumMg: magnesiumMg ?? this.magnesiumMg,
      omega3G: omega3G ?? this.omega3G,
      overallScorePct: overallScorePct ?? this.overallScorePct,
      plantSpeciesCount: plantSpeciesCount ?? this.plantSpeciesCount,
      prebioticFiberG: prebioticFiberG ?? this.prebioticFiberG,
      tryptophanMg: tryptophanMg ?? this.tryptophanMg,
      targetFermented: targetFermented ?? this.targetFermented,
      targetFiberG: targetFiberG ?? this.targetFiberG,
      targetMagnesiumMg: targetMagnesiumMg ?? this.targetMagnesiumMg,
      targetOmega3G: targetOmega3G ?? this.targetOmega3G,
      targetPlantSpecies: targetPlantSpecies ?? this.targetPlantSpecies,
      targetTryptophanMg: targetTryptophanMg ?? this.targetTryptophanMg,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (totalId.present) {
      map['total_id'] = Variable<String>(totalId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (computedAt.present) {
      map['computed_at'] = Variable<String>(computedAt.value);
    }
    if (fermentedServings.present) {
      map['fermented_servings'] = Variable<double>(fermentedServings.value);
    }
    if (magnesiumMg.present) {
      map['magnesium_mg'] = Variable<double>(magnesiumMg.value);
    }
    if (omega3G.present) {
      map['omega3_g'] = Variable<double>(omega3G.value);
    }
    if (overallScorePct.present) {
      map['overall_score_pct'] = Variable<double>(overallScorePct.value);
    }
    if (plantSpeciesCount.present) {
      map['plant_species_count'] = Variable<int>(plantSpeciesCount.value);
    }
    if (prebioticFiberG.present) {
      map['prebiotic_fiber_g'] = Variable<double>(prebioticFiberG.value);
    }
    if (tryptophanMg.present) {
      map['tryptophan_mg'] = Variable<double>(tryptophanMg.value);
    }
    if (targetFermented.present) {
      map['target_fermented'] = Variable<double>(targetFermented.value);
    }
    if (targetFiberG.present) {
      map['target_fiber_g'] = Variable<double>(targetFiberG.value);
    }
    if (targetMagnesiumMg.present) {
      map['target_magnesium_mg'] = Variable<double>(targetMagnesiumMg.value);
    }
    if (targetOmega3G.present) {
      map['target_omega3_g'] = Variable<double>(targetOmega3G.value);
    }
    if (targetPlantSpecies.present) {
      map['target_plant_species'] = Variable<int>(targetPlantSpecies.value);
    }
    if (targetTryptophanMg.present) {
      map['target_tryptophan_mg'] = Variable<double>(targetTryptophanMg.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyNutrientTotalsCompanion(')
          ..write('totalId: $totalId, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('computedAt: $computedAt, ')
          ..write('fermentedServings: $fermentedServings, ')
          ..write('magnesiumMg: $magnesiumMg, ')
          ..write('omega3G: $omega3G, ')
          ..write('overallScorePct: $overallScorePct, ')
          ..write('plantSpeciesCount: $plantSpeciesCount, ')
          ..write('prebioticFiberG: $prebioticFiberG, ')
          ..write('tryptophanMg: $tryptophanMg, ')
          ..write('targetFermented: $targetFermented, ')
          ..write('targetFiberG: $targetFiberG, ')
          ..write('targetMagnesiumMg: $targetMagnesiumMg, ')
          ..write('targetOmega3G: $targetOmega3G, ')
          ..write('targetPlantSpecies: $targetPlantSpecies, ')
          ..write('targetTryptophanMg: $targetTryptophanMg, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MealSuggestionsTable mealSuggestions = $MealSuggestionsTable(
    this,
  );
  late final $MealsTable meals = $MealsTable(this);
  late final $MealLogsTable mealLogs = $MealLogsTable(this);
  late final $DailyNutrientTotalsTable dailyNutrientTotals =
      $DailyNutrientTotalsTable(this);
  late final MealSuggestionDao mealSuggestionDao = MealSuggestionDao(
    this as AppDatabase,
  );
  late final MealDao mealDao = MealDao(this as AppDatabase);
  late final MealLogDao mealLogDao = MealLogDao(this as AppDatabase);
  late final DailyNutrientTotalsDao dailyNutrientTotalsDao =
      DailyNutrientTotalsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    mealSuggestions,
    meals,
    mealLogs,
    dailyNutrientTotals,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meals',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meal_logs', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$MealSuggestionsTableCreateCompanionBuilder =
    MealSuggestionsCompanion Function({
      required String suggestionId,
      required String userId,
      Value<String?> mealName,
      Value<String?> mealSlot,
      Value<String?> ingredients,
      Value<String?> instructions,
      Value<String?> gutBrainRationale,
      Value<String?> promptSnapshot,
      Value<String?> rawResponseJson,
      Value<String?> targetsCondition,
      required String requestedAt,
      Value<int> userAccepted,
      Value<String?> stateId,
      Value<double?> fermentedServings,
      Value<double?> magnesiumMg,
      Value<double?> omega3G,
      Value<int?> plantSpeciesCount,
      Value<double?> prebioticFiberG,
      Value<double?> tryptophanMg,
      Value<int> rowid,
    });
typedef $$MealSuggestionsTableUpdateCompanionBuilder =
    MealSuggestionsCompanion Function({
      Value<String> suggestionId,
      Value<String> userId,
      Value<String?> mealName,
      Value<String?> mealSlot,
      Value<String?> ingredients,
      Value<String?> instructions,
      Value<String?> gutBrainRationale,
      Value<String?> promptSnapshot,
      Value<String?> rawResponseJson,
      Value<String?> targetsCondition,
      Value<String> requestedAt,
      Value<int> userAccepted,
      Value<String?> stateId,
      Value<double?> fermentedServings,
      Value<double?> magnesiumMg,
      Value<double?> omega3G,
      Value<int?> plantSpeciesCount,
      Value<double?> prebioticFiberG,
      Value<double?> tryptophanMg,
      Value<int> rowid,
    });

final class $$MealSuggestionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $MealSuggestionsTable, MealSuggestion> {
  $$MealSuggestionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$MealsTable, List<Meal>> _mealsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.meals,
    aliasName: $_aliasNameGenerator(
      db.mealSuggestions.suggestionId,
      db.meals.suggestionId,
    ),
  );

  $$MealsTableProcessedTableManager get mealsRefs {
    final manager = $$MealsTableTableManager($_db, $_db.meals).filter(
      (f) => f.suggestionId.suggestionId.sqlEquals(
        $_itemColumn<String>('suggestion_id')!,
      ),
    );

    final cache = $_typedResult.readTableOrNull(_mealsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MealSuggestionsTableFilterComposer
    extends Composer<_$AppDatabase, $MealSuggestionsTable> {
  $$MealSuggestionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get suggestionId => $composableBuilder(
    column: $table.suggestionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealName => $composableBuilder(
    column: $table.mealName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealSlot => $composableBuilder(
    column: $table.mealSlot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gutBrainRationale => $composableBuilder(
    column: $table.gutBrainRationale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get promptSnapshot => $composableBuilder(
    column: $table.promptSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawResponseJson => $composableBuilder(
    column: $table.rawResponseJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetsCondition => $composableBuilder(
    column: $table.targetsCondition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userAccepted => $composableBuilder(
    column: $table.userAccepted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stateId => $composableBuilder(
    column: $table.stateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fermentedServings => $composableBuilder(
    column: $table.fermentedServings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get magnesiumMg => $composableBuilder(
    column: $table.magnesiumMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get omega3G => $composableBuilder(
    column: $table.omega3G,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plantSpeciesCount => $composableBuilder(
    column: $table.plantSpeciesCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get prebioticFiberG => $composableBuilder(
    column: $table.prebioticFiberG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tryptophanMg => $composableBuilder(
    column: $table.tryptophanMg,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> mealsRefs(
    Expression<bool> Function($$MealsTableFilterComposer f) f,
  ) {
    final $$MealsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.suggestionId,
      referencedTable: $db.meals,
      getReferencedColumn: (t) => t.suggestionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealsTableFilterComposer(
            $db: $db,
            $table: $db.meals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealSuggestionsTableOrderingComposer
    extends Composer<_$AppDatabase, $MealSuggestionsTable> {
  $$MealSuggestionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get suggestionId => $composableBuilder(
    column: $table.suggestionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealName => $composableBuilder(
    column: $table.mealName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealSlot => $composableBuilder(
    column: $table.mealSlot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gutBrainRationale => $composableBuilder(
    column: $table.gutBrainRationale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get promptSnapshot => $composableBuilder(
    column: $table.promptSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawResponseJson => $composableBuilder(
    column: $table.rawResponseJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetsCondition => $composableBuilder(
    column: $table.targetsCondition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userAccepted => $composableBuilder(
    column: $table.userAccepted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stateId => $composableBuilder(
    column: $table.stateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fermentedServings => $composableBuilder(
    column: $table.fermentedServings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get magnesiumMg => $composableBuilder(
    column: $table.magnesiumMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get omega3G => $composableBuilder(
    column: $table.omega3G,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plantSpeciesCount => $composableBuilder(
    column: $table.plantSpeciesCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get prebioticFiberG => $composableBuilder(
    column: $table.prebioticFiberG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tryptophanMg => $composableBuilder(
    column: $table.tryptophanMg,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MealSuggestionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealSuggestionsTable> {
  $$MealSuggestionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get suggestionId => $composableBuilder(
    column: $table.suggestionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get mealName =>
      $composableBuilder(column: $table.mealName, builder: (column) => column);

  GeneratedColumn<String> get mealSlot =>
      $composableBuilder(column: $table.mealSlot, builder: (column) => column);

  GeneratedColumn<String> get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => column,
  );

  GeneratedColumn<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gutBrainRationale => $composableBuilder(
    column: $table.gutBrainRationale,
    builder: (column) => column,
  );

  GeneratedColumn<String> get promptSnapshot => $composableBuilder(
    column: $table.promptSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rawResponseJson => $composableBuilder(
    column: $table.rawResponseJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetsCondition => $composableBuilder(
    column: $table.targetsCondition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get userAccepted => $composableBuilder(
    column: $table.userAccepted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stateId =>
      $composableBuilder(column: $table.stateId, builder: (column) => column);

  GeneratedColumn<double> get fermentedServings => $composableBuilder(
    column: $table.fermentedServings,
    builder: (column) => column,
  );

  GeneratedColumn<double> get magnesiumMg => $composableBuilder(
    column: $table.magnesiumMg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get omega3G =>
      $composableBuilder(column: $table.omega3G, builder: (column) => column);

  GeneratedColumn<int> get plantSpeciesCount => $composableBuilder(
    column: $table.plantSpeciesCount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get prebioticFiberG => $composableBuilder(
    column: $table.prebioticFiberG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get tryptophanMg => $composableBuilder(
    column: $table.tryptophanMg,
    builder: (column) => column,
  );

  Expression<T> mealsRefs<T extends Object>(
    Expression<T> Function($$MealsTableAnnotationComposer a) f,
  ) {
    final $$MealsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.suggestionId,
      referencedTable: $db.meals,
      getReferencedColumn: (t) => t.suggestionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealsTableAnnotationComposer(
            $db: $db,
            $table: $db.meals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealSuggestionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealSuggestionsTable,
          MealSuggestion,
          $$MealSuggestionsTableFilterComposer,
          $$MealSuggestionsTableOrderingComposer,
          $$MealSuggestionsTableAnnotationComposer,
          $$MealSuggestionsTableCreateCompanionBuilder,
          $$MealSuggestionsTableUpdateCompanionBuilder,
          (MealSuggestion, $$MealSuggestionsTableReferences),
          MealSuggestion,
          PrefetchHooks Function({bool mealsRefs})
        > {
  $$MealSuggestionsTableTableManager(
    _$AppDatabase db,
    $MealSuggestionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealSuggestionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealSuggestionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealSuggestionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> suggestionId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String?> mealName = const Value.absent(),
                Value<String?> mealSlot = const Value.absent(),
                Value<String?> ingredients = const Value.absent(),
                Value<String?> instructions = const Value.absent(),
                Value<String?> gutBrainRationale = const Value.absent(),
                Value<String?> promptSnapshot = const Value.absent(),
                Value<String?> rawResponseJson = const Value.absent(),
                Value<String?> targetsCondition = const Value.absent(),
                Value<String> requestedAt = const Value.absent(),
                Value<int> userAccepted = const Value.absent(),
                Value<String?> stateId = const Value.absent(),
                Value<double?> fermentedServings = const Value.absent(),
                Value<double?> magnesiumMg = const Value.absent(),
                Value<double?> omega3G = const Value.absent(),
                Value<int?> plantSpeciesCount = const Value.absent(),
                Value<double?> prebioticFiberG = const Value.absent(),
                Value<double?> tryptophanMg = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealSuggestionsCompanion(
                suggestionId: suggestionId,
                userId: userId,
                mealName: mealName,
                mealSlot: mealSlot,
                ingredients: ingredients,
                instructions: instructions,
                gutBrainRationale: gutBrainRationale,
                promptSnapshot: promptSnapshot,
                rawResponseJson: rawResponseJson,
                targetsCondition: targetsCondition,
                requestedAt: requestedAt,
                userAccepted: userAccepted,
                stateId: stateId,
                fermentedServings: fermentedServings,
                magnesiumMg: magnesiumMg,
                omega3G: omega3G,
                plantSpeciesCount: plantSpeciesCount,
                prebioticFiberG: prebioticFiberG,
                tryptophanMg: tryptophanMg,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String suggestionId,
                required String userId,
                Value<String?> mealName = const Value.absent(),
                Value<String?> mealSlot = const Value.absent(),
                Value<String?> ingredients = const Value.absent(),
                Value<String?> instructions = const Value.absent(),
                Value<String?> gutBrainRationale = const Value.absent(),
                Value<String?> promptSnapshot = const Value.absent(),
                Value<String?> rawResponseJson = const Value.absent(),
                Value<String?> targetsCondition = const Value.absent(),
                required String requestedAt,
                Value<int> userAccepted = const Value.absent(),
                Value<String?> stateId = const Value.absent(),
                Value<double?> fermentedServings = const Value.absent(),
                Value<double?> magnesiumMg = const Value.absent(),
                Value<double?> omega3G = const Value.absent(),
                Value<int?> plantSpeciesCount = const Value.absent(),
                Value<double?> prebioticFiberG = const Value.absent(),
                Value<double?> tryptophanMg = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealSuggestionsCompanion.insert(
                suggestionId: suggestionId,
                userId: userId,
                mealName: mealName,
                mealSlot: mealSlot,
                ingredients: ingredients,
                instructions: instructions,
                gutBrainRationale: gutBrainRationale,
                promptSnapshot: promptSnapshot,
                rawResponseJson: rawResponseJson,
                targetsCondition: targetsCondition,
                requestedAt: requestedAt,
                userAccepted: userAccepted,
                stateId: stateId,
                fermentedServings: fermentedServings,
                magnesiumMg: magnesiumMg,
                omega3G: omega3G,
                plantSpeciesCount: plantSpeciesCount,
                prebioticFiberG: prebioticFiberG,
                tryptophanMg: tryptophanMg,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MealSuggestionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mealsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (mealsRefs) db.meals],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (mealsRefs)
                    await $_getPrefetchedData<
                      MealSuggestion,
                      $MealSuggestionsTable,
                      Meal
                    >(
                      currentTable: table,
                      referencedTable: $$MealSuggestionsTableReferences
                          ._mealsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MealSuggestionsTableReferences(
                            db,
                            table,
                            p0,
                          ).mealsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.suggestionId == item.suggestionId,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MealSuggestionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealSuggestionsTable,
      MealSuggestion,
      $$MealSuggestionsTableFilterComposer,
      $$MealSuggestionsTableOrderingComposer,
      $$MealSuggestionsTableAnnotationComposer,
      $$MealSuggestionsTableCreateCompanionBuilder,
      $$MealSuggestionsTableUpdateCompanionBuilder,
      (MealSuggestion, $$MealSuggestionsTableReferences),
      MealSuggestion,
      PrefetchHooks Function({bool mealsRefs})
    >;
typedef $$MealsTableCreateCompanionBuilder =
    MealsCompanion Function({
      required String mealId,
      required String userId,
      Value<String?> suggestionId,
      Value<String?> mealName,
      Value<String?> mealSlot,
      Value<int?> plantSpeciesCount,
      Value<String?> plantSpeciesList,
      Value<double?> fermentedServings,
      Value<double?> magnesiumMg,
      Value<double?> omega3G,
      Value<double?> prebioticFiberG,
      Value<double?> tryptophanMg,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$MealsTableUpdateCompanionBuilder =
    MealsCompanion Function({
      Value<String> mealId,
      Value<String> userId,
      Value<String?> suggestionId,
      Value<String?> mealName,
      Value<String?> mealSlot,
      Value<int?> plantSpeciesCount,
      Value<String?> plantSpeciesList,
      Value<double?> fermentedServings,
      Value<double?> magnesiumMg,
      Value<double?> omega3G,
      Value<double?> prebioticFiberG,
      Value<double?> tryptophanMg,
      Value<bool> isSynced,
      Value<int> rowid,
    });

final class $$MealsTableReferences
    extends BaseReferences<_$AppDatabase, $MealsTable, Meal> {
  $$MealsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MealSuggestionsTable _suggestionIdTable(_$AppDatabase db) =>
      db.mealSuggestions.createAlias(
        $_aliasNameGenerator(
          db.meals.suggestionId,
          db.mealSuggestions.suggestionId,
        ),
      );

  $$MealSuggestionsTableProcessedTableManager? get suggestionId {
    final $_column = $_itemColumn<String>('suggestion_id');
    if ($_column == null) return null;
    final manager = $$MealSuggestionsTableTableManager(
      $_db,
      $_db.mealSuggestions,
    ).filter((f) => f.suggestionId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_suggestionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MealLogsTable, List<MealLog>> _mealLogsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.mealLogs,
    aliasName: $_aliasNameGenerator(db.meals.mealId, db.mealLogs.mealId),
  );

  $$MealLogsTableProcessedTableManager get mealLogsRefs {
    final manager = $$MealLogsTableTableManager($_db, $_db.mealLogs).filter(
      (f) => f.mealId.mealId.sqlEquals($_itemColumn<String>('meal_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_mealLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MealsTableFilterComposer extends Composer<_$AppDatabase, $MealsTable> {
  $$MealsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get mealId => $composableBuilder(
    column: $table.mealId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealName => $composableBuilder(
    column: $table.mealName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealSlot => $composableBuilder(
    column: $table.mealSlot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plantSpeciesCount => $composableBuilder(
    column: $table.plantSpeciesCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plantSpeciesList => $composableBuilder(
    column: $table.plantSpeciesList,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fermentedServings => $composableBuilder(
    column: $table.fermentedServings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get magnesiumMg => $composableBuilder(
    column: $table.magnesiumMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get omega3G => $composableBuilder(
    column: $table.omega3G,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get prebioticFiberG => $composableBuilder(
    column: $table.prebioticFiberG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tryptophanMg => $composableBuilder(
    column: $table.tryptophanMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  $$MealSuggestionsTableFilterComposer get suggestionId {
    final $$MealSuggestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.suggestionId,
      referencedTable: $db.mealSuggestions,
      getReferencedColumn: (t) => t.suggestionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealSuggestionsTableFilterComposer(
            $db: $db,
            $table: $db.mealSuggestions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> mealLogsRefs(
    Expression<bool> Function($$MealLogsTableFilterComposer f) f,
  ) {
    final $$MealLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealId,
      referencedTable: $db.mealLogs,
      getReferencedColumn: (t) => t.mealId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealLogsTableFilterComposer(
            $db: $db,
            $table: $db.mealLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealsTableOrderingComposer
    extends Composer<_$AppDatabase, $MealsTable> {
  $$MealsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get mealId => $composableBuilder(
    column: $table.mealId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealName => $composableBuilder(
    column: $table.mealName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealSlot => $composableBuilder(
    column: $table.mealSlot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plantSpeciesCount => $composableBuilder(
    column: $table.plantSpeciesCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plantSpeciesList => $composableBuilder(
    column: $table.plantSpeciesList,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fermentedServings => $composableBuilder(
    column: $table.fermentedServings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get magnesiumMg => $composableBuilder(
    column: $table.magnesiumMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get omega3G => $composableBuilder(
    column: $table.omega3G,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get prebioticFiberG => $composableBuilder(
    column: $table.prebioticFiberG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tryptophanMg => $composableBuilder(
    column: $table.tryptophanMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  $$MealSuggestionsTableOrderingComposer get suggestionId {
    final $$MealSuggestionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.suggestionId,
      referencedTable: $db.mealSuggestions,
      getReferencedColumn: (t) => t.suggestionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealSuggestionsTableOrderingComposer(
            $db: $db,
            $table: $db.mealSuggestions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealsTable> {
  $$MealsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get mealId =>
      $composableBuilder(column: $table.mealId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get mealName =>
      $composableBuilder(column: $table.mealName, builder: (column) => column);

  GeneratedColumn<String> get mealSlot =>
      $composableBuilder(column: $table.mealSlot, builder: (column) => column);

  GeneratedColumn<int> get plantSpeciesCount => $composableBuilder(
    column: $table.plantSpeciesCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get plantSpeciesList => $composableBuilder(
    column: $table.plantSpeciesList,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fermentedServings => $composableBuilder(
    column: $table.fermentedServings,
    builder: (column) => column,
  );

  GeneratedColumn<double> get magnesiumMg => $composableBuilder(
    column: $table.magnesiumMg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get omega3G =>
      $composableBuilder(column: $table.omega3G, builder: (column) => column);

  GeneratedColumn<double> get prebioticFiberG => $composableBuilder(
    column: $table.prebioticFiberG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get tryptophanMg => $composableBuilder(
    column: $table.tryptophanMg,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  $$MealSuggestionsTableAnnotationComposer get suggestionId {
    final $$MealSuggestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.suggestionId,
      referencedTable: $db.mealSuggestions,
      getReferencedColumn: (t) => t.suggestionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealSuggestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.mealSuggestions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> mealLogsRefs<T extends Object>(
    Expression<T> Function($$MealLogsTableAnnotationComposer a) f,
  ) {
    final $$MealLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealId,
      referencedTable: $db.mealLogs,
      getReferencedColumn: (t) => t.mealId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.mealLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealsTable,
          Meal,
          $$MealsTableFilterComposer,
          $$MealsTableOrderingComposer,
          $$MealsTableAnnotationComposer,
          $$MealsTableCreateCompanionBuilder,
          $$MealsTableUpdateCompanionBuilder,
          (Meal, $$MealsTableReferences),
          Meal,
          PrefetchHooks Function({bool suggestionId, bool mealLogsRefs})
        > {
  $$MealsTableTableManager(_$AppDatabase db, $MealsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> mealId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String?> suggestionId = const Value.absent(),
                Value<String?> mealName = const Value.absent(),
                Value<String?> mealSlot = const Value.absent(),
                Value<int?> plantSpeciesCount = const Value.absent(),
                Value<String?> plantSpeciesList = const Value.absent(),
                Value<double?> fermentedServings = const Value.absent(),
                Value<double?> magnesiumMg = const Value.absent(),
                Value<double?> omega3G = const Value.absent(),
                Value<double?> prebioticFiberG = const Value.absent(),
                Value<double?> tryptophanMg = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealsCompanion(
                mealId: mealId,
                userId: userId,
                suggestionId: suggestionId,
                mealName: mealName,
                mealSlot: mealSlot,
                plantSpeciesCount: plantSpeciesCount,
                plantSpeciesList: plantSpeciesList,
                fermentedServings: fermentedServings,
                magnesiumMg: magnesiumMg,
                omega3G: omega3G,
                prebioticFiberG: prebioticFiberG,
                tryptophanMg: tryptophanMg,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String mealId,
                required String userId,
                Value<String?> suggestionId = const Value.absent(),
                Value<String?> mealName = const Value.absent(),
                Value<String?> mealSlot = const Value.absent(),
                Value<int?> plantSpeciesCount = const Value.absent(),
                Value<String?> plantSpeciesList = const Value.absent(),
                Value<double?> fermentedServings = const Value.absent(),
                Value<double?> magnesiumMg = const Value.absent(),
                Value<double?> omega3G = const Value.absent(),
                Value<double?> prebioticFiberG = const Value.absent(),
                Value<double?> tryptophanMg = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealsCompanion.insert(
                mealId: mealId,
                userId: userId,
                suggestionId: suggestionId,
                mealName: mealName,
                mealSlot: mealSlot,
                plantSpeciesCount: plantSpeciesCount,
                plantSpeciesList: plantSpeciesList,
                fermentedServings: fermentedServings,
                magnesiumMg: magnesiumMg,
                omega3G: omega3G,
                prebioticFiberG: prebioticFiberG,
                tryptophanMg: tryptophanMg,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$MealsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({suggestionId = false, mealLogsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (mealLogsRefs) db.mealLogs],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (suggestionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.suggestionId,
                                    referencedTable: $$MealsTableReferences
                                        ._suggestionIdTable(db),
                                    referencedColumn: $$MealsTableReferences
                                        ._suggestionIdTable(db)
                                        .suggestionId,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (mealLogsRefs)
                        await $_getPrefetchedData<Meal, $MealsTable, MealLog>(
                          currentTable: table,
                          referencedTable: $$MealsTableReferences
                              ._mealLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MealsTableReferences(
                                db,
                                table,
                                p0,
                              ).mealLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mealId == item.mealId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MealsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealsTable,
      Meal,
      $$MealsTableFilterComposer,
      $$MealsTableOrderingComposer,
      $$MealsTableAnnotationComposer,
      $$MealsTableCreateCompanionBuilder,
      $$MealsTableUpdateCompanionBuilder,
      (Meal, $$MealsTableReferences),
      Meal,
      PrefetchHooks Function({bool suggestionId, bool mealLogsRefs})
    >;
typedef $$MealLogsTableCreateCompanionBuilder =
    MealLogsCompanion Function({
      required String logId,
      required String mealId,
      required String userId,
      required String date,
      required String mealSlot,
      required String loggedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$MealLogsTableUpdateCompanionBuilder =
    MealLogsCompanion Function({
      Value<String> logId,
      Value<String> mealId,
      Value<String> userId,
      Value<String> date,
      Value<String> mealSlot,
      Value<String> loggedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

final class $$MealLogsTableReferences
    extends BaseReferences<_$AppDatabase, $MealLogsTable, MealLog> {
  $$MealLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MealsTable _mealIdTable(_$AppDatabase db) => db.meals.createAlias(
    $_aliasNameGenerator(db.mealLogs.mealId, db.meals.mealId),
  );

  $$MealsTableProcessedTableManager get mealId {
    final $_column = $_itemColumn<String>('meal_id')!;

    final manager = $$MealsTableTableManager(
      $_db,
      $_db.meals,
    ).filter((f) => f.mealId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mealIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MealLogsTableFilterComposer
    extends Composer<_$AppDatabase, $MealLogsTable> {
  $$MealLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get logId => $composableBuilder(
    column: $table.logId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealSlot => $composableBuilder(
    column: $table.mealSlot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  $$MealsTableFilterComposer get mealId {
    final $$MealsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealId,
      referencedTable: $db.meals,
      getReferencedColumn: (t) => t.mealId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealsTableFilterComposer(
            $db: $db,
            $table: $db.meals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $MealLogsTable> {
  $$MealLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get logId => $composableBuilder(
    column: $table.logId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealSlot => $composableBuilder(
    column: $table.mealSlot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  $$MealsTableOrderingComposer get mealId {
    final $$MealsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealId,
      referencedTable: $db.meals,
      getReferencedColumn: (t) => t.mealId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealsTableOrderingComposer(
            $db: $db,
            $table: $db.meals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealLogsTable> {
  $$MealLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get logId =>
      $composableBuilder(column: $table.logId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get mealSlot =>
      $composableBuilder(column: $table.mealSlot, builder: (column) => column);

  GeneratedColumn<String> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  $$MealsTableAnnotationComposer get mealId {
    final $$MealsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealId,
      referencedTable: $db.meals,
      getReferencedColumn: (t) => t.mealId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealsTableAnnotationComposer(
            $db: $db,
            $table: $db.meals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealLogsTable,
          MealLog,
          $$MealLogsTableFilterComposer,
          $$MealLogsTableOrderingComposer,
          $$MealLogsTableAnnotationComposer,
          $$MealLogsTableCreateCompanionBuilder,
          $$MealLogsTableUpdateCompanionBuilder,
          (MealLog, $$MealLogsTableReferences),
          MealLog,
          PrefetchHooks Function({bool mealId})
        > {
  $$MealLogsTableTableManager(_$AppDatabase db, $MealLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> logId = const Value.absent(),
                Value<String> mealId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> mealSlot = const Value.absent(),
                Value<String> loggedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealLogsCompanion(
                logId: logId,
                mealId: mealId,
                userId: userId,
                date: date,
                mealSlot: mealSlot,
                loggedAt: loggedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String logId,
                required String mealId,
                required String userId,
                required String date,
                required String mealSlot,
                required String loggedAt,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealLogsCompanion.insert(
                logId: logId,
                mealId: mealId,
                userId: userId,
                date: date,
                mealSlot: mealSlot,
                loggedAt: loggedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MealLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mealId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mealId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.mealId,
                                referencedTable: $$MealLogsTableReferences
                                    ._mealIdTable(db),
                                referencedColumn: $$MealLogsTableReferences
                                    ._mealIdTable(db)
                                    .mealId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MealLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealLogsTable,
      MealLog,
      $$MealLogsTableFilterComposer,
      $$MealLogsTableOrderingComposer,
      $$MealLogsTableAnnotationComposer,
      $$MealLogsTableCreateCompanionBuilder,
      $$MealLogsTableUpdateCompanionBuilder,
      (MealLog, $$MealLogsTableReferences),
      MealLog,
      PrefetchHooks Function({bool mealId})
    >;
typedef $$DailyNutrientTotalsTableCreateCompanionBuilder =
    DailyNutrientTotalsCompanion Function({
      required String totalId,
      required String userId,
      required String date,
      required String computedAt,
      Value<double?> fermentedServings,
      Value<double?> magnesiumMg,
      Value<double?> omega3G,
      Value<double?> overallScorePct,
      Value<int?> plantSpeciesCount,
      Value<double?> prebioticFiberG,
      Value<double?> tryptophanMg,
      Value<double?> targetFermented,
      Value<double?> targetFiberG,
      Value<double?> targetMagnesiumMg,
      Value<double?> targetOmega3G,
      Value<int?> targetPlantSpecies,
      Value<double?> targetTryptophanMg,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$DailyNutrientTotalsTableUpdateCompanionBuilder =
    DailyNutrientTotalsCompanion Function({
      Value<String> totalId,
      Value<String> userId,
      Value<String> date,
      Value<String> computedAt,
      Value<double?> fermentedServings,
      Value<double?> magnesiumMg,
      Value<double?> omega3G,
      Value<double?> overallScorePct,
      Value<int?> plantSpeciesCount,
      Value<double?> prebioticFiberG,
      Value<double?> tryptophanMg,
      Value<double?> targetFermented,
      Value<double?> targetFiberG,
      Value<double?> targetMagnesiumMg,
      Value<double?> targetOmega3G,
      Value<int?> targetPlantSpecies,
      Value<double?> targetTryptophanMg,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$DailyNutrientTotalsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyNutrientTotalsTable> {
  $$DailyNutrientTotalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get totalId => $composableBuilder(
    column: $table.totalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get computedAt => $composableBuilder(
    column: $table.computedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fermentedServings => $composableBuilder(
    column: $table.fermentedServings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get magnesiumMg => $composableBuilder(
    column: $table.magnesiumMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get omega3G => $composableBuilder(
    column: $table.omega3G,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get overallScorePct => $composableBuilder(
    column: $table.overallScorePct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plantSpeciesCount => $composableBuilder(
    column: $table.plantSpeciesCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get prebioticFiberG => $composableBuilder(
    column: $table.prebioticFiberG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tryptophanMg => $composableBuilder(
    column: $table.tryptophanMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetFermented => $composableBuilder(
    column: $table.targetFermented,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetFiberG => $composableBuilder(
    column: $table.targetFiberG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetMagnesiumMg => $composableBuilder(
    column: $table.targetMagnesiumMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetOmega3G => $composableBuilder(
    column: $table.targetOmega3G,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetPlantSpecies => $composableBuilder(
    column: $table.targetPlantSpecies,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetTryptophanMg => $composableBuilder(
    column: $table.targetTryptophanMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyNutrientTotalsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyNutrientTotalsTable> {
  $$DailyNutrientTotalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get totalId => $composableBuilder(
    column: $table.totalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get computedAt => $composableBuilder(
    column: $table.computedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fermentedServings => $composableBuilder(
    column: $table.fermentedServings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get magnesiumMg => $composableBuilder(
    column: $table.magnesiumMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get omega3G => $composableBuilder(
    column: $table.omega3G,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get overallScorePct => $composableBuilder(
    column: $table.overallScorePct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plantSpeciesCount => $composableBuilder(
    column: $table.plantSpeciesCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get prebioticFiberG => $composableBuilder(
    column: $table.prebioticFiberG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tryptophanMg => $composableBuilder(
    column: $table.tryptophanMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetFermented => $composableBuilder(
    column: $table.targetFermented,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetFiberG => $composableBuilder(
    column: $table.targetFiberG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetMagnesiumMg => $composableBuilder(
    column: $table.targetMagnesiumMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetOmega3G => $composableBuilder(
    column: $table.targetOmega3G,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetPlantSpecies => $composableBuilder(
    column: $table.targetPlantSpecies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetTryptophanMg => $composableBuilder(
    column: $table.targetTryptophanMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyNutrientTotalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyNutrientTotalsTable> {
  $$DailyNutrientTotalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get totalId =>
      $composableBuilder(column: $table.totalId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get computedAt => $composableBuilder(
    column: $table.computedAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fermentedServings => $composableBuilder(
    column: $table.fermentedServings,
    builder: (column) => column,
  );

  GeneratedColumn<double> get magnesiumMg => $composableBuilder(
    column: $table.magnesiumMg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get omega3G =>
      $composableBuilder(column: $table.omega3G, builder: (column) => column);

  GeneratedColumn<double> get overallScorePct => $composableBuilder(
    column: $table.overallScorePct,
    builder: (column) => column,
  );

  GeneratedColumn<int> get plantSpeciesCount => $composableBuilder(
    column: $table.plantSpeciesCount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get prebioticFiberG => $composableBuilder(
    column: $table.prebioticFiberG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get tryptophanMg => $composableBuilder(
    column: $table.tryptophanMg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetFermented => $composableBuilder(
    column: $table.targetFermented,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetFiberG => $composableBuilder(
    column: $table.targetFiberG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetMagnesiumMg => $composableBuilder(
    column: $table.targetMagnesiumMg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetOmega3G => $composableBuilder(
    column: $table.targetOmega3G,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetPlantSpecies => $composableBuilder(
    column: $table.targetPlantSpecies,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetTryptophanMg => $composableBuilder(
    column: $table.targetTryptophanMg,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$DailyNutrientTotalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyNutrientTotalsTable,
          DailyNutrientTotal,
          $$DailyNutrientTotalsTableFilterComposer,
          $$DailyNutrientTotalsTableOrderingComposer,
          $$DailyNutrientTotalsTableAnnotationComposer,
          $$DailyNutrientTotalsTableCreateCompanionBuilder,
          $$DailyNutrientTotalsTableUpdateCompanionBuilder,
          (
            DailyNutrientTotal,
            BaseReferences<
              _$AppDatabase,
              $DailyNutrientTotalsTable,
              DailyNutrientTotal
            >,
          ),
          DailyNutrientTotal,
          PrefetchHooks Function()
        > {
  $$DailyNutrientTotalsTableTableManager(
    _$AppDatabase db,
    $DailyNutrientTotalsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyNutrientTotalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyNutrientTotalsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DailyNutrientTotalsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> totalId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> computedAt = const Value.absent(),
                Value<double?> fermentedServings = const Value.absent(),
                Value<double?> magnesiumMg = const Value.absent(),
                Value<double?> omega3G = const Value.absent(),
                Value<double?> overallScorePct = const Value.absent(),
                Value<int?> plantSpeciesCount = const Value.absent(),
                Value<double?> prebioticFiberG = const Value.absent(),
                Value<double?> tryptophanMg = const Value.absent(),
                Value<double?> targetFermented = const Value.absent(),
                Value<double?> targetFiberG = const Value.absent(),
                Value<double?> targetMagnesiumMg = const Value.absent(),
                Value<double?> targetOmega3G = const Value.absent(),
                Value<int?> targetPlantSpecies = const Value.absent(),
                Value<double?> targetTryptophanMg = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyNutrientTotalsCompanion(
                totalId: totalId,
                userId: userId,
                date: date,
                computedAt: computedAt,
                fermentedServings: fermentedServings,
                magnesiumMg: magnesiumMg,
                omega3G: omega3G,
                overallScorePct: overallScorePct,
                plantSpeciesCount: plantSpeciesCount,
                prebioticFiberG: prebioticFiberG,
                tryptophanMg: tryptophanMg,
                targetFermented: targetFermented,
                targetFiberG: targetFiberG,
                targetMagnesiumMg: targetMagnesiumMg,
                targetOmega3G: targetOmega3G,
                targetPlantSpecies: targetPlantSpecies,
                targetTryptophanMg: targetTryptophanMg,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String totalId,
                required String userId,
                required String date,
                required String computedAt,
                Value<double?> fermentedServings = const Value.absent(),
                Value<double?> magnesiumMg = const Value.absent(),
                Value<double?> omega3G = const Value.absent(),
                Value<double?> overallScorePct = const Value.absent(),
                Value<int?> plantSpeciesCount = const Value.absent(),
                Value<double?> prebioticFiberG = const Value.absent(),
                Value<double?> tryptophanMg = const Value.absent(),
                Value<double?> targetFermented = const Value.absent(),
                Value<double?> targetFiberG = const Value.absent(),
                Value<double?> targetMagnesiumMg = const Value.absent(),
                Value<double?> targetOmega3G = const Value.absent(),
                Value<int?> targetPlantSpecies = const Value.absent(),
                Value<double?> targetTryptophanMg = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyNutrientTotalsCompanion.insert(
                totalId: totalId,
                userId: userId,
                date: date,
                computedAt: computedAt,
                fermentedServings: fermentedServings,
                magnesiumMg: magnesiumMg,
                omega3G: omega3G,
                overallScorePct: overallScorePct,
                plantSpeciesCount: plantSpeciesCount,
                prebioticFiberG: prebioticFiberG,
                tryptophanMg: tryptophanMg,
                targetFermented: targetFermented,
                targetFiberG: targetFiberG,
                targetMagnesiumMg: targetMagnesiumMg,
                targetOmega3G: targetOmega3G,
                targetPlantSpecies: targetPlantSpecies,
                targetTryptophanMg: targetTryptophanMg,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyNutrientTotalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyNutrientTotalsTable,
      DailyNutrientTotal,
      $$DailyNutrientTotalsTableFilterComposer,
      $$DailyNutrientTotalsTableOrderingComposer,
      $$DailyNutrientTotalsTableAnnotationComposer,
      $$DailyNutrientTotalsTableCreateCompanionBuilder,
      $$DailyNutrientTotalsTableUpdateCompanionBuilder,
      (
        DailyNutrientTotal,
        BaseReferences<
          _$AppDatabase,
          $DailyNutrientTotalsTable,
          DailyNutrientTotal
        >,
      ),
      DailyNutrientTotal,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MealSuggestionsTableTableManager get mealSuggestions =>
      $$MealSuggestionsTableTableManager(_db, _db.mealSuggestions);
  $$MealsTableTableManager get meals =>
      $$MealsTableTableManager(_db, _db.meals);
  $$MealLogsTableTableManager get mealLogs =>
      $$MealLogsTableTableManager(_db, _db.mealLogs);
  $$DailyNutrientTotalsTableTableManager get dailyNutrientTotals =>
      $$DailyNutrientTotalsTableTableManager(_db, _db.dailyNutrientTotals);
}
