<template>
  <el-container>
    <el-aside style="width: 72px;">
      <el-menu class="asideMenu" :default-active="activeNumber">
        <el-menu-item index="1"><i class="icon el-icon-fork-spoon"></i></el-menu-item>
        <el-menu-item><i class="icon el-icon-user-solid"></i></el-menu-item>
        <el-menu-item><i class="icon el-icon-picture-outline"></i></el-menu-item>
        <el-menu-item><i class="icon el-icon-message-solid"></i></el-menu-item>
        <el-menu-item><i class="icon el-icon-info"></i></el-menu-item>
      </el-menu>
    </el-aside>
    <h1>check</h1>
  </el-container>
</template>

<script>
export default {
  data(){
    return { activeNumber: "1" }
  }
}
</script>

<style>
/* .el-container {
  background: #fff;
  height: 100vh;
}
.el-aside {
  background: #fff;
  display: flex;
  flex-direction: column;
  justify-content: center;
}
.asideMenu {
  background: #ddd;
  flex-direction: column;
}
.el-menu-item {
  text-align: center;
  font-size: 24px;
  border-bottom: 1px solid #999;
} */
</style>