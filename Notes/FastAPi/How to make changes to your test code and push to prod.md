
On dev system
```git
git add -all
git commit -m "some message"
git push origin main
```

On prod system

```
git pull
sudo systemctl restart fastapi # name of your service that you created
```
