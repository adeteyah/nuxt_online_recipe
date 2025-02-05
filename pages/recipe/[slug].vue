<script>
export default {
  setup() {
    const json = ref(null);
    const route = useRoute();

    onMounted(async () => {
      const url = `https://dummyjson.com/recipes/${route.params.slug}`;
      try {
        const response = await fetch(url);
        json.value = await response.json();
        console.log(json);
      } catch (error) {
        console.error(error.message);
      }
    });

    return { json };
  },
};
</script>

<template>
  <div class="p-4">
    <NuxtLink to="/">Home</NuxtLink>
    <div v-if="json">
      {{ json.name }}
      {{ json.difficulty }}
      <NuxtImg :src="json.image" />
      <ol>
        <li v-for="instruction in json.instructions">
          {{ instruction }}
        </li>
      </ol>
      <p>Prep minutes: {{ json.prepTimeMinutes }}</p>
      <p>Cook minutes: {{ json.cookTimeMinutes }}</p>
      <p>Servings: {{ json.servings }}</p>
      <p>Calories per serving: {{ json.caloriesPerServing }}</p>
      <p>Cuisine : {{ json.cuisine }}</p>
      <p>Rating : {{ json.rating }}</p>
      <p>Review Count : {{ json.reviewCount }}</p>
      Tag:
      <ol>
        <li v-for="tag in json.tags">
          {{ tag }}
        </li>
      </ol>
      Meal Type
      <ol>
        <li v-for="type in json.mealType">
          {{ type }}
        </li>
      </ol>
    </div>
  </div>
</template>
