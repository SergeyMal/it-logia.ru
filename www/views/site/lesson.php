<?php

/** @var yii\web\View $this */


use yii\helpers\Html;
use yii\helpers\Url;

/** @var array $data */
$this->title = 'Урок: '.$data['name'];
?>
<div class="site-about">
    <h1 id="name_lesson"><?= Html::encode($this->title) ?></h1>
    <p id="comment"><?=$data['comment']?></p>
    <div id="youtube"><?=$data['youtube_url']?></div>
    <p><input type="hidden" id="id_lesson" value="<?=$data['id']?>">
        <?
        echo Html::button('урок просмотрен', ['id' => 'btn_complete', 'class' => 'btn btn-primary',
            'onclick' => "
                            $.ajax ({
                                type: 'POST',
                                dataType: 'json',
                                data: { id_lesson: $('#id_lesson').val(), action : 'true' },
                                success: function(data) { 
                                if (data != null){
                                    $('#name_lesson').html(data['name']);
                                    $('#comment').html(data['comment']);
                                    $('#youtube').html(data['youtube_url']);
                                    $('#id_lesson').val(data['id']);       
                                    }else{
                                    $(location).attr('href','".Url::home(true)."');}                       
                                }
                            });
                    "]);
        ?></p>
</div>
