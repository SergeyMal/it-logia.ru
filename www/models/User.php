<?php

namespace app\models;

use Yii;
use yii\base\Exception;
use yii\db\ActiveRecord;
use yii\web\IdentityInterface;

/**
 * User model
 *
 * @property integer id
 * @property string login
 * @property string password
 * @property string name
 * @property string auth_key
 * @property string sess_start
 */
class User extends ActiveRecord implements IdentityInterface
{
    public $rememberMe = true;

    public static function tableName()
    {
        return 'user';
    }

    /**
     * @return array the validation rules.
     */
    public function rules()
    {
        return [
            // name, email, subject and body are required
            [['name', 'login', 'password'], 'trim'],
            [['name', 'login', 'password'], 'required'],
            ['login', 'unique'],
            ['rememberMe', 'boolean'],
        ];
    }

    public static function findByUsername($login){
        return static::findOne(['login' => $login]);
    }

    /**
     * @return array customized attribute labels
     */
    public function attributeLabels()
    {
        return [
            'verifyCode' => 'Verification Code',
            'login' => 'Login',
            'password' => 'Пароль',
            'name' => 'Имя пользователя'
        ];
    }

    /**
     * Validates password
     *
     * @param string $password password to validate
     * @return boolean if password provided is valid for current user
     */
    public function validatePassword(string $password)
    {
        return Yii::$app->security->validatePassword($password, $this->password);
    }

    /**
     * Generates password hash from password and sets it to the model
     *
     * @param string $password
     * @throws Exception
     */
    public function setPassword(string $password)
    {
        $this->password = Yii::$app->security->generatePasswordHash($password);
    }

    public static function findIdentity($id)
    {
        return static::findOne(['id' => $id]);
    }

    public static function findIdentityByAccessToken($token, $type = null)
    {
        throw new NotSupportedException('"findIdentityByAccessToken" is not implemented.');
    }

    public function getId()
    {
        return $this->getPrimaryKey();
    }

    public function getAuthKey()
    {
        if($this->auth_key == ''){
            $this->generateAuthKey();
            $this->save();
        } else {
            $sess_start = Yii::$app->db->createCommand('SELECT sess_start FROM user WHERE id=:id')
                ->bindValue(':id', $this->id)
                ->queryScalar();
            $sess_start = date_create_from_format('Y-m-d H:i:s', $sess_start);
            $now = date_create('now');
            if(date_diff($sess_start, $now)->h > 4){
                $this->generateAuthKey();
                $this->save();
            }
        }
        return $this->auth_key;
    }

    public function generateAuthKey(){
        $this->auth_key = Yii::$app->security->generateRandomString();
    }

    public function validateAuthKey($authKey)
    {
        return $this->getAuthKey() === $authKey;
    }
}
