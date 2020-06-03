<template>
    <el-aside class="sideBarWrapper">
      <el-menu class="asideMenu" :default-active="activeNumber">
        <el-menu-item index="1"><i class="icon el-icon-fork-spoon"></i></el-menu-item>
        <el-menu-item index="2"><i class="icon el-icon-user-solid"></i></el-menu-item>
        <el-menu-item index="3"><i class="icon el-icon-picture-outline"></i></el-menu-item>
        <el-menu-item index="4"><i class="icon el-icon-message-solid"></i></el-menu-item>
        <el-menu-item index="5"><i class="icon el-icon-info"></i></el-menu-item>
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
  padding-left: 0;
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