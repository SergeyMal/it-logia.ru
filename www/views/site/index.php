<?php

use yii\data\ActiveDataProvider;
use yii\grid\GridView;
use yii\helpers\Html;

/* @var $dataProvider ActiveDataProvider */

$this->title = 'My Yii Application';
?>
<div class="site-index">

    <div class="jumbotron text-center bg-transparent">
        <h1 class="display-4">Уроки курса!</h1>
    </div>
<!--    <p class="text-success text-center">You have successfully created your Yii-powered application.</p>-->

    <div class="body-content">
        <?php
        echo GridView::widget([
            'dataProvider' => $dataProvider,
            'columns' => [
                ['class' => 'yii\grid\SerialColumn'],
                [
                    'attribute' => 'name',
                    'value' => function ($data) {
                        return ($data['complete'] ? Html::img('@web/img/symbol-check.png').' ' : '') . Html::a($data['name'], ['lesson', 'lesson' => $data['id']],
                                ['class' => 'glyphicon glyphicon-ok']);
                    },
                    'format' => 'html',
                ],
                'comment'
            ],]);
        ?>
    </div>
</div>
