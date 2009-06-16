;; kitty.in.th-soft-filter.scm
;; v. 0.07
;; Author Kitt Tientanopajai <kitty@kitty.in.th>
;; Copyright (C) 2005 Kitt Tientanopajai"
;;
;; This is a free software and can be redistributed under GNU GPL version 2.
;; 
;; Soft filter effect
;;
;; ChangeLogs
;; v0.07 - Mon, 15 Dec 2008 22:40:12 +0700
;; - Move to Filters menu

(define (kitty.in.th-soft-filter image drawable radius saturation)
	(let* (
		(image-layer (car (gimp-layer-new-from-drawable drawable image)))
		(soft-layer (car (gimp-layer-new-from-drawable drawable image))))

		(gimp-image-undo-group-start image)

		(gimp-layer-set-name image-layer "kitty.in.th - color adjust")
		(gimp-image-add-layer image image-layer -1)
		(gimp-layer-set-name soft-layer "kitty.in.th - soft")
		(gimp-image-add-layer image soft-layer -1)

		(gimp-layer-set-opacity soft-layer 50)
		(gimp-layer-set-mode soft-layer SCREEN)
		(plug-in-gauss-iir 1 image soft-layer radius radius radius)

		(gimp-levels-stretch image-layer)
		(gimp-levels image-layer HISTOGRAM-VALUE 0 255 0.7 0 255)
		(gimp-hue-saturation image-layer 0 0 0 -20)

		(gimp-displays-flush)
		(gimp-image-undo-group-end image)))

(script-fu-register
	"kitty.in.th-soft-filter"
	"<Image>/Filters/kitty.in.th/Soft Filter..."
	"kitty.in.th soft filter effect v.0.07"
	"Kitt Tientanopajai"
	"Copyright (C) 2005-2008 Kitt Tientanopajai"
	"December 15, 2008"
	"RGB RGBA GRAY GRAYA"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Drawable" 0
	SF-ADJUSTMENT "Blur radius" '(60 0 255 1 5 0 0)
	SF-ADJUSTMENT "Saturation" '(-20 -100 0 1 5 0 0))
