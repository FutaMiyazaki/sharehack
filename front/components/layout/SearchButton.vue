<template>
  <v-tooltip bottom color="primary">
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        depressed
        v-bind="attrs"
        class="mr-3 hidden-sm-and-down"
        to="/item/create"
        v-on="on"
      >
        <v-icon color="primary">mdi-magnify</v-icon>
      </v-btn>
    </template>
    <span class="white--text font-weight-bold">検索</span>
  </v-tooltip>
</template>
