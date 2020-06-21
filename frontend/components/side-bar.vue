<template>
    <el-aside class="sideBarWrapper">
      <el-menu class="asideMenu" :default-active="activeNumber">
        <el-menu-item index="1">
          <nuxt-link to="/posts">
            <i class="icon el-icon-fork-spoon"></i>
            <p class="item_name">POSTS</p>
          </nuxt-link>
        </el-menu-item>
        <el-menu-item index="2">
          <nuxt-link to="/users">
            <i class="icon el-icon-user-solid"></i>
            <p class="item_name">USERS</p>
          </nuxt-link>
        </el-menu-item>
        <el-menu-item index="3">
          <nuxt-link to="/posts/new">
            <i class="icon el-icon-circle-plus-outline"></i>
            <p class="item_name">CREATE</p>
          </nuxt-link>
        </el-menu-item>
        <el-menu-item index="4">
          <nuxt-link to="/posts/search">
            <i class="icon el-icon-search"></i>
            <p class="item_name">SEARCH</p>
          </nuxt-link>
        </el-menu-item>
        <el-menu-item index="5">
          <nuxt-link :to="{ path: `/users/${$store.state.auth.currentUser.id}` }">
            <i class="icon el-icon-setting"></i>
            <p class="item_name">SETTING</p>
          </nuxt-link>
        </el-menu-item>
      </el-menu>
    </el-aside>
</template>

<script>
export default {
  data(){
    return { activeNumber: "1" }
  }
}
</script>

<style>
.sideBarWrapper {
  display: flex;
  height: 100vh;
  width: 60px !important;
  padding-left: 0;
  flex-direction: column;
  justify-content: center;
  position: fixed;
  top: 0;
  z-index: 11;
}
.sideBarWrapper .asideMenu {
  background: #ddd;
  flex-direction: column;
}
.sideBarWrapper .el-menu-item {
  text-align: center;
  font-size: 24px;
  border-bottom: 1px solid #999;
  padding: 0 !important;
}
.sideBarWrapper a {
  padding: 0;
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.sideBarWrapper .item_name {
  font-size: 10px;
  line-height: 0;
  margin-top: 10px;
  color: #555;
  font-weight: bold;
}
@media (min-width: 0px) and (max-width: 640px) {
  .sideBarWrapper {
    position: fixed;
    top: auto;
    bottom: 0;
    left: 0;
    width: 100% !important;
    height: 60px;
  }
  .sideBarWrapper .asideMenu {
    flex-direction: row;
    width: 100%;
    display: flex;
    height: 60px;
    justify-content: space-between;
  }
  .sideBarWrapper .el-menu-item {
    text-align: center;
    font-size: 24px;
    border: none;
    padding-left: 0;
  }
  .sideBarWrapper .el-menu-item:hover ,
  .sideBarWrapper .el-menu-item:focus {
    background: none;
  }
}
</style>