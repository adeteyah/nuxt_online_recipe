<script>
export default {
  setup() {
    const json = ref(null);
    let limit = ref(10);
    let skip = ref(0);

    async function fetchData() {
      const url = `https://dummyjson.com/recipes/?limit=${limit.value}&skip=${skip.value}`;
      try {
        const response = await fetch(url);
        json.value = await response.json();
      } catch (error) {
        console.error(error.message);
      }
    }
    watchEffect(() => {
      fetchData();
    });

    const prevPage = () => {
      skip.value -= limit.value;
    };

    const nextPage = () => {
      skip.value += limit.value;
    };

    return { json, skip, limit, nextPage, prevPage };
  },
};
</script>

<template>
  <div class="p-4">
    <ul v-if="json && json.recipes">
      <li v-for="recipe in json.recipes" :key="recipe.id">
        <NuxtLink :to="`/recipe/${recipe.id}`">{{ recipe.name }}</NuxtLink>
      </li>
    </ul>
    <div>Items per page <input type="text" :value="skip" /></div>
    <button v-on:click="prevPage">Previous</button>
    <br />
    <button v-on:click="nextPage">Next</button>
  </div>
</template>
