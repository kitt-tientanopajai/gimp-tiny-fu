;; kitty.in.th-sepia.scm
;; v. 0.07
;; Author Kitt Tientanopajai <kitty@kitty.in.th>
;; Copyright (C) 2005-2008 Kitt Tientanopajai"
;;
;; This is a free software and can be redistributed under GNU GPL version 2.
;; 
;; Sepia effect
;;
;; ChangeLogs
;; v0.07 - Mon, 15 Dec 2008 22:40:12 +0700
;; - Move to Filters menu

(define (kitty.in.th-sepia image drawable)
	(let* (
		(image-width (car (gimp-image-width image)))
		(image-height (car (gimp-image-height image)))
		(image-layer (car (gimp-layer-new-from-drawable drawable image)))
		(sepia-layer (car (gimp-layer-new image image-width image-height RGBA-IMAGE "kitty.in.th - sepia" 36 COLOR)))
		(fg-color (car (gimp-context-get-foreground))))

		(gimp-image-undo-group-start image)

		(gimp-layer-set-name image-layer "kitty.in.th - grayscale")
		(gimp-image-add-layer image image-layer -1)
		(gimp-image-add-layer image sepia-layer -1)
		(plug-in-colors-channel-mixer 1 image image-layer TRUE 0.3 0.59 0.11 0.3 0.59 0.11 0.3 0.59 0.11)
		
		(gimp-context-set-foreground '(112 66 20))
		(gimp-drawable-fill sepia-layer FOREGROUND-FILL)

		(gimp-context-set-foreground fg-color)
		(gimp-displays-flush)
		(gimp-image-undo-group-end image)))

(script-fu-register
	"kitty.in.th-sepia"
	"<Image>/Filters/kitty.in.th/Sepia"
	"kitty.in.th sepia color effect v.0.07"
	"Kitt Tientanopajai"
	"Copyright (C) 2005-2008 Kitt Tientanopajai"
	"December 15, 2008"
	"RGB RGBA GRAY GRAYA"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Drawable" 0)
