<template>
  <v-tooltip bottom color="primary">
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        depressed
        v-bind="attrs"
        class="mr-3 hidden-sm-and-down"
        to="/topic/create"
        v-on="on"
      >
        <v-icon color="primary">mdi-pencil-box-multiple</v-icon>
      </v-btn>
    </template>
    <span class="white--text font-weight-bold">トピック投稿</span>
  </v-tooltip>
</template>
