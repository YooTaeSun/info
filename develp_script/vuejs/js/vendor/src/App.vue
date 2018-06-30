<template>
  <div id="app">
    <!-- Global Component, check main.js -->
    <nav-header></nav-header>
    <global-cmp></global-cmp>
    <login-form></login-form>
    <local-cmp></local-cmp>
  </div>
   
</template>

<script>
  import LoginForm from './components/LoginForm.vue';
  import LocalCmp from './components/LocalCmp.vue';

  export default {
    components: {
      'login-form': LoginForm,
      // 할일 #1
      // Local 컴포넌트를 하나 등록하고, login form 아래에 렌더링 해보세요.
      'local-cmp' : LocalCmp
    }
  }
</script>

<style lang="scss">
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

h1, h2 {
  font-weight: normal;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #42b983;
}
</style>
