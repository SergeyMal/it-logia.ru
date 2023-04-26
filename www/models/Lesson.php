<?php
namespace app\models;

use Yii;
use yii\base\Exception;
use yii\data\ActiveDataProvider;
use yii\db\ActiveRecord;

class Lesson extends ActiveRecord{
    public static function tableName(){
        return 'lesson';
    }

    public function attributeLabels()
    {
        return [
            'name' => 'Название урока',
            'comment' => 'Описание урока'
        ];
    }

    public function search()
    {
        $query = Lesson::find()->where(['user_id' => Yii::$app->user->id]);

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
            'pagination' => [
                'pageSize' => 50,
            ],
        ]);
        return $dataProvider;
    }

    public function getLesson($param, $newLesson = false){
        if ($newLesson){
            $model = Lesson::findOne(['id' => $param]);
            $model->complete = true;
            $model->save();
            return Lesson::find()->where(['complete' => false])
                ->orderBy('id')
                ->asArray()->one();
        }else
        return Lesson::find()->where(['id' => $param])
            ->orderBy('id')
            ->asArray()->one();
    }
}